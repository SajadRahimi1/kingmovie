import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';

AppBar homeAppBar({required BuildContext context}) => AppBar(
      backgroundColor: darkBlue,
      title: const Text(
        'کینگ مووی',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.public,
          ),
        )
      ],
      iconTheme: IconThemeData(
        color: Colors.white,
        size: MediaQuery.sizeOf(context).width / 13,
      ),
      leading: const Icon(
        Icons.menu_rounded,
      ),
    );

    AppBar screenAppBar({required BuildContext context,String title=""}) => AppBar(
      backgroundColor: darkBlue,
      title:  Text(
       title,
        style:const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.home,
          ),
        )
      ],
      iconTheme: IconThemeData(
        color: Colors.white,
        size: MediaQuery.sizeOf(context).width / 13,
      ),
      leading: const Icon(
        Icons.menu_rounded,
      ),
    );
