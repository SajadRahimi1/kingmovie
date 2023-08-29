import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';

class SettingBottomSheet extends StatelessWidget {
  const SettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt colorSelected = (-1).obs, fontSize = 34.obs;
    return Wrap(
      children: [
        ListTile(
          title: const Text("تغییر رنگ زیرنویس"),
          trailing: SizedBox(
            width: MediaQuery.sizeOf(context).width / 2,
            height: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  4,
                  (index) => InkWell(
                        onTap: () => colorSelected.value = index,
                        child: Obx(() => CircleAvatar(
                              backgroundColor: [
                                Colors.blue,
                                Colors.black,
                                Colors.yellow,
                                Colors.red
                              ][index],
                              child: Center(
                                  child: index == colorSelected.value
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null),
                            )),
                      )),
            ),
          ),
        ),
        ListTile(
          title: const Text("اندازه فونت زیرنویس"),
          trailing: SizedBox(
            width: Get.width / 3,
            child: Row(children: [
              InkWell(
                  onTap: () => fontSize.value++,
                  child: CircleAvatar(
                    radius: Get.width / 26,
                    backgroundColor: Colors.green,
                    child: const Center(
                        child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
                  )),
              Obx(() => Text(
                    "\t${fontSize.value}\t",
                    style: TextStyle(
                        fontSize: 16 * MediaQuery.of(context).textScaleFactor),
                  )),
              InkWell(
                  onTap: () => fontSize.value--,
                  child: CircleAvatar(
                    radius: Get.width / 26,
                    backgroundColor: Colors.red,
                    child: const Center(
                        child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    )),
                  )),
            ]),
          ),
        ),
        InkWell(
          onTap: ()=>Get.back(
            result: TextStyle(fontSize: fontSize.value.toDouble(),color: [
                                Colors.blue,
                                Colors.black,
                                Colors.yellow,
                                Colors.red
                              ][colorSelected.value]),

            
          ),
          child: Container(
            width: Get.width,
            alignment: Alignment.center,
            height: Get.height / 17,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: redColor),
            child: const Text(
              "ذخیره",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
