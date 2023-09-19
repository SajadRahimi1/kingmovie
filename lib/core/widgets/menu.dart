import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/constants/singleton_class.dart';
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
        InkWell(
          onTap: toLoginScreen,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 5,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: MediaQuery.sizeOf(context).width / 6,
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height / 45),
          child: Text(
            SingletonClass.instance.user?.name ?? "کاربر مهمان",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        if (SingletonClass.instance.user != null)
          const Divider(
            color: Color(0xff5f5f5f),
          ),
        SingletonClass.instance.user == null
            ? ListTile(
                onTap: loginTap,
                textColor: Colors.white,
                title: Text(
                  "ورود / ثبت نام",
                  style: TextStyle(
                      fontSize: 12 * MediaQuery.of(context).textScaleFactor),
                ),
                trailing: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
              )
            : ListTile(
                onTap: toProfileScreen,
                textColor: Colors.white,
                title: Text(
                  "تنظیمات کاربری",
                  style: TextStyle(
                      fontSize: 12 * MediaQuery.of(context).textScaleFactor),
                ),
                trailing: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
        if (SingletonClass.instance.user != null)
          const Divider(
            color: Color(0xff5f5f5f),
          ),
        if (SingletonClass.instance.user != null)
          ListTile(
            onTap: toVipScreen,
            textColor: Colors.white,
            title: Text(
              "اشتراک ویژه دانلود",
              style: TextStyle(
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor),
            ),
            trailing: const Icon(
              Icons.downloading_rounded,
              color: Colors.white,
            ),
          ),
        if (SingletonClass.instance.user != null)
          const Divider(
            color: Color(0xff5f5f5f),
          ),
        if (SingletonClass.instance.user != null)
          ListTile(
            onTap: toReuestScreen,
            textColor: Colors.white,
            title: Text(
              "درخواست ها",
              style: TextStyle(
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor),
            ),
            trailing: const Icon(
              Icons.movie,
              color: Colors.white,
            ),
          ),
        if (SingletonClass.instance.user != null)
          const Divider(
            color: Color(0xff5f5f5f),
          ),
        if (SingletonClass.instance.user != null)
          ListTile(
            onTap: toFavoriteScreen,
            textColor: Colors.white,
            title: Text(
              "لیست مورد علاقه",
              style: TextStyle(
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor),
            ),
            trailing: const Icon(
              Icons.star,
              color: Colors.white,
            ),
          ),
        if (SingletonClass.instance.user != null)
          const Divider(
            color: Color(0xff5f5f5f),
          ),
        if (SingletonClass.instance.user != null)
          ListTile(
            onTap: toTransactionScreen,
            textColor: Colors.white,
            title: Text(
              "سوابق پرداخت",
              style: TextStyle(
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor),
            ),
            trailing: const Icon(
              Icons.payment,
              color: Colors.white,
            ),
          ),
        if (SingletonClass.instance.user != null)
          const Divider(
            color: Color(0xff5f5f5f),
          ),
        if (SingletonClass.instance.user != null)
          ListTile(
            onTap: toTicketsScreen,
            textColor: Colors.white,
            title: Text(
              "تیکت و پشتیبانی",
              style: TextStyle(
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor),
            ),
            trailing: const Icon(
              Icons.support_agent,
              color: Colors.white,
            ),
          ),
        if (SingletonClass.instance.user != null)
          const Divider(
            color: Color(0xff5f5f5f),
          ),
        if (SingletonClass.instance.user != null)
          ListTile(
            onTap: () {
              exit();
              Scaffold.of(context).closeDrawer();
            },
            textColor: Colors.white,
            title: Text(
              "خروج",
              style: TextStyle(
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor),
            ),
            trailing: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
      ]),
    );
  }
}
