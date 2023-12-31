import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';

class ProfileTextInput extends StatelessWidget {
  const ProfileTextInput(
      {super.key,
      required this.label,
      this.textEditingController,
      this.isEnable = true,
      this.obsecure = false,
      this.onChanged,
      this.maxLines = 1});
  final String label;
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;
  final bool isEnable, obsecure;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        // height: MediaQuery.sizeOf(context).height / 1,
        child: TextFormField(
          enabled: isEnable,
          onChanged: onChanged,
          controller: textEditingController,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          maxLines: maxLines,
          obscureText: obsecure,
          decoration: InputDecoration(
            fillColor: blackColor,
            labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
            filled: true,
            labelText: label,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xff3f3f3f))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xff3f3f3f))),
          ),
        ),
      ),
    );
  }
}
