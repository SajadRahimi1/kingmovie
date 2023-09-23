import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/viewmodels/vip_viewmodel.dart';

class VipScreen extends StatelessWidget {
  const VipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VipViewModel());
    RxInt planSelected = 3.obs;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        centerTitle: true,
        title: const Text(
          "« اشتراک ویژه »",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      backgroundColor: blackColor,
      body: controller.obx((state) => ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: const Text(
                  "لطفا هنگام پرداخت به نکات زیر توجه کنید.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: redColor),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                "1- از مرورگر گوگل کروم یا فایرفاکس استفاه کنید ترجیحا.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12 * MediaQuery.of(context).textScaleFactor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Text(
                  "2- مرحله آخر خرید حتما گزینه \"تکمیل خرید\" رو بزنید تا خرید کامل بشه.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12 * MediaQuery.of(context).textScaleFactor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Text(
                  "3- اشتراک تهیه شده به هیچ عنوان قابل لغو کردن و عودت وجه نخواهد شد.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12 * MediaQuery.of(context).textScaleFactor),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                "4- در صورت بروز هرگونه مشکل به بخش \"پشتیبانی\" پیام بدید تا برسی بشه.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12 * MediaQuery.of(context).textScaleFactor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                indent: MediaQuery.sizeOf(context).width / 10,
                endIndent: MediaQuery.sizeOf(context).width / 10,
                color: Colors.white,
                thickness: 2,
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: redColor,
              ),
              child: Column(
                  children: List.generate(
                      controller.homeModel?.pack?.length ?? 0,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => ListTile(
                                  tileColor: darkBlue,
                                  onTap: () => planSelected.value = index,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white,
                                          strokeAlign: 0.05)),
                                  leading: Radio(
                                    activeColor: Colors.white,
                                    value: planSelected.value,
                                    groupValue: index,
                                    onChanged: <int>(value) {},
                                  ),
                                  title: Text(
                                    controller.homeModel?.pack?[index].title ??
                                        "",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                )),
                          ))),
            ),
            SizedBox(
              height: Get.height / 35,
            ),
            InkWell(
              onTap: () async {
                await controller.buy(
                    controller.homeModel?.pack?[planSelected.value].id ?? 0);
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 15,
                decoration: const BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Text(
                  "خرید سرویس",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18 * MediaQuery.of(context).textScaleFactor),
                ),
              ),
            )
          ])),
    );
  }
}
