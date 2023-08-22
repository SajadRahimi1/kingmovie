import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';

class ProfileTextInput extends StatelessWidget {
  const ProfileTextInput(
      {super.key, required this.label, this.textEditingController});
  final String label;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height / 15,
        child: TextFormField(
          controller: textEditingController,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          decoration: InputDecoration(
            fillColor: blackColor,
            labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
            filled: true,
            labelText: label,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xff3f3f3f))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xff3f3f3f))),
          ),
        ),
      ),
    );
  }
}
