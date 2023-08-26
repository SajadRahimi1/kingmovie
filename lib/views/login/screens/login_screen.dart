import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/viewmodels/login_viewmodel.dart';
import 'package:king_movie/views/menu/widgets/profile_text_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginViewModel());

    return Scaffold(
      appBar: menuAppBar(context: context, title: "« ورود »"),
      backgroundColor: darkBlue,
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: ProfileTextInput(
                label: "ایمیل",
                onChanged: (value) => controller.email = value,
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: ProfileTextInput(
                label: "رمز عبور",
                onChanged: (value) => controller.password = value,
              )),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 20,
          ),
          const InkWell(
            child: Text(
              "اگر رمز عبور خود را فراموش کرده اید اینجا کلیک نمایید",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: controller.login,
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
                "ورود",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
