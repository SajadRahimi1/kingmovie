import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/constants/singleton_class.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/profile_service.dart' as service;
import 'package:king_movie/models/home_model.dart';
import 'package:king_movie/models/user_model.dart';

class ProfileViewModel extends GetxController {
  final GetStorage getStorage = GetStorage();
  String token = '';

  SingletonClass singletonClass = SingletonClass.instance;

  UserModel userModel = UserModel();

  String password = '', repassword = '';

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token') ?? '';
    userModel.token = token;
  }

  Future<void> updateInformation() async {
    final request = await service.updateInformation(userModel: userModel);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      singletonClass.user = User.fromJson(request.body['user']);
      showMessage(
          title: 'ویرایش اطلاعات',
          message: 'ویرایش اطلاعات را موفقیت انجام شد',
          type: MessageType.success);
    } else {
      networkErrorMessage();
    }
  }

  Future<void> updatePassword() async {
    if (password == repassword) {
      final request =
          await service.updatePassword(password: password, token: token);
      if (request.statusCode == 200 && request.body['error'] == 'false') {
        singletonClass.user = User.fromJson(request.body['user']);
        showMessage(
            title: 'ویرایش رمز عبور',
            message: 'تغییر رمز عبور را موفقیت انجام شد',
            type: MessageType.success);
      } else {
        networkErrorMessage();
      }
    } else {
      showMessage(
          title: 'خطا',
          message: 'رمز عبور و تکرار آن یکسان نیست',
          type: MessageType.warning);
    }
  }
}
