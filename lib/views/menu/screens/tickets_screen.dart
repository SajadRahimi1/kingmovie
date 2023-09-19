import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/viewmodels/ticket_viewmodel.dart';
import 'package:king_movie/views/menu/screens/show_ticket_screen.dart';
import 'package:king_movie/views/menu/widgets/profile_text_input.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TicketViewModel());

    return Scaffold(
        appBar: menuAppBar(context: context, title: "« تیکت و پشتیبانی »"),
        backgroundColor: darkBlue,
        body: controller.obx(
          (status) => ListView(
            padding: const EdgeInsets.all(8),
            children: [
              // table header
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 17,
                decoration: const BoxDecoration(
                    color: Color(0xff26313e),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Row(children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.5,
                    height: MediaQuery.sizeOf(context).height,
                    child: const Center(
                      child: Text(
                        "عنوان",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    color: Color(0xff26313e),
                    thickness: 1,
                  ),
                  const Expanded(
                      child: Text(
                    "وضعیت",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ))
                ]),
              ),

              // table items
              Column(
                children: List.generate(
                  controller.ticketModel?.data?.list?.length ?? 0,
                  (index) => InkWell(
                    onTap: () => Get.to(() => ShowTicketScreen(
                          code:
                              controller.ticketModel?.data?.list?[index].code ??
                                  "",
                                  token: controller.token,
                        )),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height / 17,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff26313e)),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Row(children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.5,
                          height: MediaQuery.sizeOf(context).height,
                          child: Center(
                            child: Text(
                              controller
                                      .ticketModel?.data?.list?[index].title ??
                                  "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Color(0xff26313e),
                          thickness: 3,
                        ),
                        Expanded(
                            child: Text(
                          controller.ticketModel?.data?.list?[index].active ??
                              "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  12 * MediaQuery.of(context).textScaleFactor),
                        ))
                      ]),
                    ),
                  ),
                ),
              ),

              Obx(() => controller.isClickNew.value
                  ? Column(
                      children: [
                        ProfileTextInput(
                          label: "عنوان تیکت جدید",
                          onChanged: (value) => controller.ticketTitle = value,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ProfileTextInput(
                          label: "متن پیام",
                          onChanged: (value) => controller.ticketText = value,
                        ),
                      ],
                    )
                  : const SizedBox()),

              // new ticket button
              InkWell(
                onTap: () async {
                  if (controller.isClickNew.value) {
                    await controller.newTicket();
                  } else {
                    controller.isClickNew.value = true;
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: MediaQuery.sizeOf(context).width / 3.2),
                  decoration: BoxDecoration(
                      color: redColor, borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: Obx(() => Text(
                        controller.isClickNew.value
                            ? "ارسال پیام"
                            : "ثبت تیکت جدید",
                        style: const TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
