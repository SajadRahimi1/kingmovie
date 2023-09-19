import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/views/home/screens/main_screen.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.offAll(() => const MainScreen());
    });
    return const Scaffold(
      backgroundColor: blackColor,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
