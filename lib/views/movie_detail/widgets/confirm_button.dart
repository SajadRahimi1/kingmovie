import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.text,  this.statusOnClick=false});
  final String text;
  final bool statusOnClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context, statusOnClick),
      child: Container(
        // width: MediaQuery.sizeOf(context).width / 5,
        // height: MediaQuery.sizeOf(context).height / 35,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width / 14, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: redColor, borderRadius: BorderRadius.circular(8)),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
