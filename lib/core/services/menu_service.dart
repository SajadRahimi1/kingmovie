import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/constants/singleton_class.dart';
import 'package:king_movie/core/widgets/login_dialog.dart';
import 'package:king_movie/views/login/screens/login_screen.dart';
import 'package:king_movie/views/login/screens/singup_screen.dart';
import 'package:king_movie/views/menu/screens/favorites_screen.dart';
import 'package:king_movie/views/menu/screens/profile_screen.dart';
import 'package:king_movie/views/menu/screens/request_movie_screen.dart';
import 'package:king_movie/views/menu/screens/tickets_screen.dart';
import 'package:king_movie/views/menu/screens/transactions_screen.dart';
import 'package:king_movie/views/menu/screens/vip_screen.dart';

void toVipScreen() =>
    Get.to(() => const VipScreen(), transition: Transition.leftToRight);

void toProfileScreen() =>
    Get.to(() => const ProfileScreen(), transition: Transition.leftToRight);

void toReuestScreen() => Get.to(() => const RequestMovieScreen(),
    transition: Transition.leftToRight);

void toFavoriteScreen() =>
    Get.to(() => const FavoritesScreen(), transition: Transition.leftToRight);

void toTransactionScreen() => Get.to(() => const TransactionsScreen(),
    transition: Transition.leftToRight);

void toTicketsScreen() =>
    Get.to(() => const TicketsScreen(), transition: Transition.leftToRight);

void toLoginScreen() =>
    Get.to(() => const LoginScreen(), transition: Transition.leftToRight);

void loginTap() {
  Get.dialog(LoginDialog(
    onLoginTap: () =>
        Get.to(() => const LoginScreen(), transition: Transition.leftToRight),
    onSingupTap: () =>
        Get.to(() => const SingupScreen(), transition: Transition.leftToRight),
  ));
}

void exit() {
  final GetStorage getStorage = GetStorage();
  GetStorage.init().then((value) {
    getStorage.remove('token');
    SingletonClass.instance.user = null;    
  });
}
