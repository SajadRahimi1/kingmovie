import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';

class Messagewidget extends StatelessWidget {
  const Messagewidget(
      {Key? key,
      required this.isUserSend,
      required this.text,
      required this.time,
      required this.messageIcon})
      : super(key: key);
  final bool isUserSend;
  final String text, time;
  final Icon messageIcon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserSend ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        // padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isUserSend ? blackColor : const Color(0xff26313e),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
            bottomRight: isUserSend ? Radius.zero : const Radius.circular(10.0),
            bottomLeft: isUserSend ? const Radius.circular(10.0) : Radius.zero,
          ),
        ),
        child: Column(
          crossAxisAlignment: RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(text)
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: Text(
                (isUserSend ? "شما:" : "مدیریت:"),
                style: TextStyle(
                    fontSize: 13 * MediaQuery.of(context).textScaleFactor,
                    color: Colors.white),
              ),
            ),
            Text(
              text,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontSize: 13 * MediaQuery.of(context).textScaleFactor,
                  color: Colors.white),
            ),
            Text(
              time,
              style: TextStyle(
                  fontSize: 11 * MediaQuery.of(context).textScaleFactor,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
