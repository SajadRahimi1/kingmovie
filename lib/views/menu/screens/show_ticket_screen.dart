import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/views/menu/widgets/message_widget.dart';

class ShowTicketScreen extends StatelessWidget {
  const ShowTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkBlue,
        appBar: menuAppBar(context: context, title: "« مشاهده تیکت »"),
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(children: [
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 15),
                    physics: const BouncingScrollPhysics(),
                    reverse: false,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) =>
                        Messagewidget(
                            isUserSend: index % 2 == 0,
                            text: [
                              // "SALAM VIP SUBSCRIBE MAN FAAL NASHODE? CHECK MIKONID MAM NON",
                              "سلام",
                              "سلام، حساب شما تا 1401/04/25 23:59:59 شارژ شد"
                            ][index],
                            time: "چهارشنبه, 25 خرداد 1401",
                            messageIcon: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: MediaQuery.sizeOf(context).width / 20,
                            )))),
            // const Divider(
            //   color: Colors.w,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Get.height / 15,
                      child: TextFormField(
                        // controller: _controller.textEditingController,
                        textInputAction: TextInputAction.done,
                        textAlignVertical: TextAlignVertical.bottom,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: Get.width / 30, color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(2) +
                              const EdgeInsets.symmetric(horizontal: 5),
                          focusColor: Colors.green,
                          alignLabelWithHint: true,
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: Colors.green,
                            ),
                            onPressed: () async {},
                          ),
                          hintText: 'پیام خود را بنویس',
                          hintStyle: TextStyle(
                              fontSize: Get.width / 30, color: Colors.white),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
            ),
          ]),
        ));
  }
}
