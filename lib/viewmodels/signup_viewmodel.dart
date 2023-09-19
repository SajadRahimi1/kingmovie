import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/login_service.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/models/signup_model.dart';
import 'package:king_movie/views/home/screens/main_screen.dart';

class SignupViewModel extends GetxController {
  final GetStorage getStorage = GetStorage();
  SignupModel model = SignupModel();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
  }

  Future<void> sendData() async {
    if (validate()) {
      final request = await signup(signupModel: model);
      if (request.statusCode == 200 && request.body['error'] == 'false') {
        await getStorage.write('token', request.body['salt']);
        Get.offAll(() => const MainScreen());
      } else {
        showMessage(
            title: 'خطا',
            message: request.body['message'],
            type: MessageType.error);
      }
    }
  }

  bool validate() {
    if (model.email?.isEmpty ?? true) {
      showMessage(
          message: 'ایمیل را وارد کنید',
          title: 'خطا',
          type: MessageType.warning);
      return false;
    }
    if (model.mobile?.isEmpty ?? true) {
      showMessage(
          message: 'موبایل را وارد کنید',
          title: 'خطا',
          type: MessageType.warning);
      return false;
    }
    if (model.name?.isEmpty ?? true) {
      showMessage(
          message: ' نام را وارد کنید',
          title: 'خطا',
          type: MessageType.warning);
      return false;
    }
    if (model.password?.isEmpty ?? true) {
      showMessage(
          message: 'رمز را وارد کنید', title: 'خطا', type: MessageType.warning);
      return false;
    }
    if (model.repassword?.isEmpty ?? true) {
      showMessage(
          message: 'تکرار رمز را وارد کنید',
          title: 'خطا',
          type: MessageType.warning);
      return false;
    }
    if (model.password != model.repassword) {
      showMessage(
          message: 'رمز و تکرار رمز یکی نیست',
          title: 'خطا',
          type: MessageType.warning);
      return false;
    }
    return true;
  }
}
