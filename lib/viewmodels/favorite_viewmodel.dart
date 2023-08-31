import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/watch_service.dart' as service;
import 'package:king_movie/models/favorite_model.dart';

class FavoriteViewModel extends GetxController with StateMixin {
  final GetStorage getStorage = GetStorage();
  String token = '';

  FavoriteModel? favoriteModel;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token') ?? '';
    await getData();
  }

  Future<void> getData() async {
    final request = await service.getFavoriteList(token);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      favoriteModel = FavoriteModel.fromJson(request.body);
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(request.body['message']));
    }
  }

  Future<void> removeFavorite(String id) async {
    change(null, status: RxStatus.loading());
    final request = await service.addFavorite(token, id);
    showMessage(
        message: request.body['message'],
        type: request.body['error'] == 'false'
            ? MessageType.success
            : MessageType.error);
    await getData();
  }
}
