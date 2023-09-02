import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:king_movie/views/home/screens/main_screen.dart';
import 'package:media_kit/media_kit.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  MediaKit.ensureInitialized();
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorType = EasyLoadingIndicatorType.fadingFour;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Sans",
        ),
        builder: EasyLoading.init(
            builder: (context, child) => Directionality(
                textDirection: TextDirection.rtl,
                child: child ?? const SizedBox())),
        home: const MainScreen());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
