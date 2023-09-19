import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/viewmodels/signup_viewmodel.dart';
import 'package:king_movie/views/login/screens/login_screen.dart';
import 'package:king_movie/views/menu/widgets/profile_text_input.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupViewModel());

    return Scaffold(
      appBar: menuAppBar(context: context, title: "« ثبت نام کاربر »"),
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBlue,
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: ProfileTextInput(
                label: "ایمیل",
                onChanged: (value) => controller.model.email = value,
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: ProfileTextInput(
                  label: "موبایل",
                  onChanged: (value) => controller.model.mobile = value)),
          Padding(
              padding: const EdgeInsets.all(10),
              child: ProfileTextInput(
                  label: "نام و نام خانوادگی",
                  onChanged: (value) => controller.model.name = value)),
          Padding(
              padding: const EdgeInsets.all(10),
              child: ProfileTextInput(
                  label: "رمز عبور دلخواه",
                  onChanged: (value) => controller.model.password = value)),
          Padding(
              padding: const EdgeInsets.all(10),
              child: ProfileTextInput(
                  label: "تکرار رمز عبور",
                  onChanged: (value) => controller.model.repassword = value)),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 20,
          ),
          InkWell(
            onTap: () => Get.to(() => const LoginScreen()),
            child: const Text(
              "قبلا عضو شده اید؟ از اینجا وارد حساب کاربری شوید",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: controller.sendData,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 13,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: redColor),
              alignment: Alignment.center,
              child: const Text(
                "ثبت",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
