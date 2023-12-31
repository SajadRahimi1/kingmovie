import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:king_movie/views/check_login.dart';
import 'package:media_kit/media_kit.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  MediaKit.ensureInitialized();
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorType = EasyLoadingIndicatorType.fadingFour;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBKC5TZB_MTgGGVWtf_SbLGc9VsVd5a6dc',
          appId: '1:571731271520:android:4eb20dd40085290a048805',
          messagingSenderId: '571731271520',
          projectId: 'king-movie-d3fa8'));
  print("token: ${await FirebaseMessaging.instance.getToken() ?? ''}");

  await FirebaseMessaging.instance.requestPermission(provisional: true);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.requestPermission(provisional: true);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Sans",
        ),
        builder: EasyLoading.init(
            builder: (context, child) => Directionality(
                textDirection: TextDirection.rtl,
                child: child ?? const SizedBox())),
        home: const FirstPage());
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
