import 'package:get/get.dart';
import 'package:king_movie/core/services/login_service.dart' as service;
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/message_service.dart';
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
      await getStorage.write('token', request.body['salt']);
      Get.offAll(() => const MainScreen(
            isLogedIn: true,
          ));
    } else {
      showMessage(
          title: 'خطا',
          message: request.body['message'],
          type: MessageType.error);
    }
  }

  Future<void> forget() async {
    final request = await service.forget(
      email: email,
    );
    Get.back();
    showMessage(message: request.body['message'], type: MessageType.info);
  }
}
