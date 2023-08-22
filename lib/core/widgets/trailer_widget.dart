import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';

class TrailerWidget extends StatelessWidget {
  const TrailerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width / 12,
          vertical: MediaQuery.sizeOf(context).height / 55),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height / 4.5,
        child: Stack(children: [
          Image.network(
            "https://www.doostihaa.com/img/uploads/2023/06/Elemental-2023.jpg",
            fit: BoxFit.fill,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 4.5,
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 4.5,
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CircleAvatar(
                  radius: MediaQuery.sizeOf(context).width / 15,
                  backgroundColor: Colors.white,
                  child: Center(
                      child: Icon(
                    Icons.play_arrow,
                    color: blackColor,
                    size: MediaQuery.sizeOf(context).width / 14,
                  ))),
            ),
          )
        ]),
      ),
    );
  }
}
