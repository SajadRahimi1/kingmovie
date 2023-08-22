import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/views/menu/widgets/profile_text_input.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        centerTitle: true,
        title: const Text(
          "« تنظیمات کاربری »",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      backgroundColor: darkBlue,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width / 25),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height / 45),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: MediaQuery.sizeOf(context).width / 5.5,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Icon(
                    Icons.change_circle,
                    size: MediaQuery.sizeOf(context).width / 10,
                    color: redColor,
                  ),
                ),
              ),
            ),
          ),
          ProfileTextInput(
            label: "ایمیل",
          ),
          ProfileTextInput(
            label: "موبایل",
          ),
          ProfileTextInput(
            label: "نام و نام خانوادگی",
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: redColor, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              "ثبت تغیرات",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "اگر قصد تغییر رمز عبور را دارید از فرم زیر استفاده نمایید",
              style: TextStyle(color: Color(0xff5f5f5f)),
            ),
          ),
          const ProfileTextInput(label: "رمز عبور جدید"),
          const ProfileTextInput(label: "تکرار رمز عبور"),
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: redColor, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              "تغیر رمز عبور",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
