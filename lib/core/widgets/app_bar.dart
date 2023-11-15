import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/views/home/screens/main_screen.dart';

AppBar homeAppBar(
        {required BuildContext context,
        int alertLenght = 0,
        void Function()? onWebTap,
        void Function()? onAlarmTap}) =>
    AppBar(
      backgroundColor: darkBlue,
      title: const Text(
        'کینگ مووی',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        if (alertLenght > 0)
          InkWell(
            onTap: onAlarmTap,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: Get.height / 55,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: redColor),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    alertLenght.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ]),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: InkWell(
            onTap: onWebTap,
            child: const Icon(
              Icons.public,
            ),
          ),
        ),
      ],
      iconTheme: IconThemeData(
        color: Colors.white,
        size: MediaQuery.sizeOf(context).width / 13,
      ),
      leading: Builder(builder: (context) {
        return InkWell(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: const Icon(
            Icons.menu_rounded,
          ),
        );
      }),
    );

AppBar screenAppBar({required BuildContext context, String title = ""}) =>
    AppBar(
      backgroundColor: darkBlue,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        InkWell(
          onTap: () => Get.offAll(() => const MainScreen()),
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.home,
            ),
          ),
        )
      ],
      iconTheme: IconThemeData(
        color: Colors.white,
        size: MediaQuery.sizeOf(context).width / 13,
      ),

      // leading: Builder(builder: (context) {
      //   return InkWell(
      //     onTap: () => Scaffold.of(context).openDrawer(),
      //     child: const Icon(
      //       Icons.menu_rounded,
      //     ),
      //   );
      // }),
    );

AppBar menuAppBar({required BuildContext context, String? title}) => AppBar(
      backgroundColor: darkBlue,
      centerTitle: true,
      title: Text(
        title ?? "",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
    );
