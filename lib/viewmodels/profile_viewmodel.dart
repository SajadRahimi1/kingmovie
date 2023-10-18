import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:king_movie/core/constants/singleton_class.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/profile_service.dart' as service;
import 'package:king_movie/models/home_model.dart';
import 'package:king_movie/models/user_model.dart';

class ProfileViewModel extends GetxController {
  final GetStorage getStorage = GetStorage();
  String token = '';

  RxString ticketImage = "".obs;

  SingletonClass singletonClass = SingletonClass.instance;

  UserModel userModel = UserModel();

  String password = '', repassword = '';

  @override
  void onInit() async {
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token') ?? '';
    userModel.token = token;
    userModel.name = singletonClass.user?.name;
    userModel.mobile = singletonClass.user?.mobile;
  }

  Future<void> updateInformation() async {
    if (ticketImage.isNotEmpty) userModel.image = ticketImage.value;
    final request = await service.updateInformation(userModel: userModel);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      singletonClass.user = User.fromJson(request.body['user']);
      showMessage(
          title: 'ویرایش اطلاعات',
          message: 'ویرایش اطلاعات را موفقیت انجام شد',
          type: MessageType.success);
      await DefaultCacheManager().removeFile(
          '${baseUrl}upload/profile_${SingletonClass.instance.user?.id}.jpg');
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
      } else if (request.statusCode == 500) {
        networkErrorMessage();
      } else {
        showMessage(
            title: 'خطا',
            message: request.body['message'],
            type: MessageType.warning);
      }
    } else {
      showMessage(
          title: 'خطا',
          message: 'رمز عبور و تکرار آن یکسان نیست',
          type: MessageType.warning);
    }
  }

  Future<void> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (image != null) {
      ticketImage.value = image.path;
    }
  }
}
