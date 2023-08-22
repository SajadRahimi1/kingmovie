import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/services/menu_service.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(color: blackColor),
      child: Column(children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height / 5,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: MediaQuery.sizeOf(context).width / 6,
              )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height / 45),
          child: const Text(
            "کاربر مهمان",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        const Divider(
          color: Color(0xff5f5f5f),
        ),
        const ListTile(
          onTap: toProfileScreen,
          textColor: Colors.white,
          title: Text("تنظیمات کاربری"),
          trailing: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
        const Divider(
          color: Color(0xff5f5f5f),
        ),
        const ListTile(
          onTap: toVipScreen,
          textColor: Colors.white,
          title: Text("اشتراک ویژه دانلود"),
          trailing: Icon(
            Icons.downloading_rounded,
            color: Colors.white,
          ),
        ),
        const Divider(
          color: Color(0xff5f5f5f),
        ),
        const ListTile(
          onTap: toReuestScreen,
          textColor: Colors.white,
          title: Text("درخواست ها"),
          trailing: Icon(
            Icons.movie,
            color: Colors.white,
          ),
        ),
        const Divider(
          color: Color(0xff5f5f5f),
        ),
        const ListTile(
          onTap: toFavoriteScreen,
          textColor: Colors.white,
          title: Text("لیست مورد علاقه"),
          trailing: Icon(
            Icons.star,
            color: Colors.white,
          ),
        ),
        const Divider(
          color: Color(0xff5f5f5f),
        ),
        const ListTile(
          textColor: Colors.white,
          title: Text("سوابق پرداخت"),
          trailing: Icon(
            Icons.payment,
            color: Colors.white,
          ),
        ),
        const Divider(
          color: Color(0xff5f5f5f),
        ),
        const ListTile(
          textColor: Colors.white,
          title: Text("تیکت و پشتیبانی"),
          trailing: Icon(
            Icons.support_agent,
            color: Colors.white,
          ),
        ),
        const Divider(
          color: Color(0xff5f5f5f),
        ),
        const ListTile(
          textColor: Colors.white,
          title: Text("خروج"),
          trailing: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
