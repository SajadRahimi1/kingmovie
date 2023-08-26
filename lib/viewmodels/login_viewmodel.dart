import 'package:get/get.dart';
import 'package:king_movie/core/services/login_service.dart' as service;
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/views/home/screens/main_screen.dart';

class LoginViewModel extends GetxController with StateMixin {
  String email = '', password = '';
  final GetStorage getStorage = GetStorage();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
  }

  Future<void> login() async {
    final request = await service.login(email: email, password: password);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      getStorage.write('token', request.body['salt']);
      Get.offAll(() => const MainScreen());
    } else {
      // TODO: show error message
      print(request.body['message']);
    }
  }
}
