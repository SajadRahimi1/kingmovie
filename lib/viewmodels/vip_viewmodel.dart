import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/home_service.dart' as service;
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/vip_service.dart';
import 'package:king_movie/models/home_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VipViewModel extends GetxController with StateMixin {
  HomeModel? homeModel;
  String token = '';
  final GetStorage getStorage = GetStorage();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token');
    print(token);
    await getData();
  }

  Future<void> getData() async {
    final request = await service.homeService();
    if (request.statusCode == 200) {
      homeModel = HomeModel.fromJson(request.body);
      change(null, status: RxStatus.success());
    }
  }

  Future<void> buy(int pack) async {
    final request = await buyVip(pack: pack, token: token);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      launchUrlString(request.body['url'],
          mode: LaunchMode.externalApplication);
    } else {
      showMessage(
          title: 'خطا',
          message: request.body['message'],
          type: MessageType.error);
    }
  }
}
