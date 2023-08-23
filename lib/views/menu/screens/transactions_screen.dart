import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: menuAppBar(context: context, title: "« سوابق پرداخت »"),
      backgroundColor: darkBlue,
      body: ListView(
        padding: EdgeInsets.all(8),
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
                    "تاریخ",
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
                "مبلغ",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ))
            ]),
          ),
          Container(
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
                    "چهارشنبه, 25 خرداد 1401 - ساعت 00:41",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13 * MediaQuery.of(context).textScaleFactor),
                  ),
                ),
              ),
              const VerticalDivider(
                color: Color(0xff26313e),
                thickness: 3,
              ),
              Expanded(
                  child: Text(
                "30000",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13 * MediaQuery.of(context).textScaleFactor),
              ))
            ]),
          ),
        ],
      ),
    );
  }
}
