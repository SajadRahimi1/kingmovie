import 'package:get/route_manager.dart';
import 'package:king_movie/views/menu/screens/profile_screen.dart';
import 'package:king_movie/views/menu/screens/vip_screen.dart';

void toVipScreen() =>
    Get.to(() => const VipScreen(), transition: Transition.leftToRight);


 void toProfileScreen() =>
    Get.to(() => const ProfileScreen(), transition: Transition.leftToRight);   
