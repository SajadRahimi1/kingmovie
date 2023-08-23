import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/views/menu/screens/show_ticket_screen.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: menuAppBar(context: context, title: "« تیکت و پشتیبانی »"),
      backgroundColor: darkBlue,
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 17,
            decoration: const BoxDecoration(
                color: Color(0xff26313e),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
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
          InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShowTicketScreen())),
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
                      "VIP SUBSCRIBE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              13 * MediaQuery.of(context).textScaleFactor),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Color(0xff26313e),
                  thickness: 3,
                ),
                Expanded(
                    child: Text(
                  "پاسخ داده شده",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12 * MediaQuery.of(context).textScaleFactor),
                ))
              ]),
            ),
          ),

          // new ticket button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: MediaQuery.sizeOf(context).width / 3.2),
            decoration: BoxDecoration(
                color: redColor, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Text(
              "ثبت تیکت جدید",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
