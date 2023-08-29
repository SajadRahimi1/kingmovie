import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/constants/singleton_class.dart';
import 'package:king_movie/core/services/home_service.dart' as service;
import 'package:king_movie/models/home_model.dart';

class HomeViewModel extends GetxController with StateMixin {
  HomeModel? homeModel;
  String searchValue = '';

  final GetStorage getStorage = GetStorage();
  String token = '';

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
    final request = await service.homeService(token);
    if (request.statusCode == 200) {
      homeModel = HomeModel.fromJson(request.body);
      SingletonClass.instance.user = homeModel?.user;
      change(null, status: RxStatus.success());
    }
  }
}
