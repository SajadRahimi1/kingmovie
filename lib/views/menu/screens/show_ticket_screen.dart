import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/viewmodels/ticket_message_viewmodel.dart';
import 'package:king_movie/views/menu/widgets/message_widget.dart';
import 'package:king_movie/core/extensions/string_extension.dart';

class ShowTicketScreen extends StatelessWidget {
  const ShowTicketScreen({Key? key, required this.code, required this.token})
      : super(key: key);
  final String code, token;

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(TicketMessageViewmModel(code: code, token: token));
    return Scaffold(
        backgroundColor: darkBlue,
        appBar: menuAppBar(context: context, title: "« مشاهده تیکت »"),
        body: controller.obx((status) => SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 15),
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.model?.data?.list?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) =>
                            Messagewidget(
                                isUserSend: (controller
                                            .model?.data?.list?[index].sender ??
                                        "") ==
                                    "توسط شما",
                                text: (controller
                                            .model?.data?.list?[index].text ??
                                        "")
                                    .removeAllHtmlTags(),
                                time:
                                    controller.model?.data?.list?[index].date ??
                                        "",
                                messageIcon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: MediaQuery.sizeOf(context).width / 20,
                                )))),
                // const Divider(
                //   color: Colors.w,
                // ),
                /*
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
            ),*/
              ]),
            )));
  }
}
