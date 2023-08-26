import 'package:get/get.dart';
import 'package:king_movie/core/services/home_service.dart' as service;
import 'package:king_movie/models/home_model.dart';

class HomeViewModel extends GetxController with StateMixin {
  HomeModel? homeModel;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getData();
  }

  Future<void> getData() async {
    final request = await service.homeService();
    if (request.statusCode == 200) {
      homeModel = HomeModel.fromJson(request.body);
      change(null, status: RxStatus.success());
    }
  }
}
