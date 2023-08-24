import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key, this.onLoginTap, this.onSingupTap});
  final void Function()? onLoginTap, onSingupTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height / 2.5,
        horizontal: MediaQuery.sizeOf(context).width / 8,
      ),
      child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // type: MaterialType.transparency,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "برای استفاده از خدمات ابتدا وارد اپ شوید",
                style: TextStyle(color: darkBlue),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onLoginTap,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: darkBlue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "وارد شوید",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onSingupTap,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: darkBlue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "ثبت نام کنید",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
