import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/request_movie_service.dart' as service;
import 'package:king_movie/models/movie_request_model.dart';

class RequestMovieViewModel extends GetxController with StateMixin {
  final GetStorage getStorage = GetStorage();
  String token = '';
  String id = '';
  RequestMovieModel? movieModel;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token') ?? '';
    await getData();
  }

  Future<void> requestMovie() async {
    final request = await service.requestMovie(token, id);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      showMessage(message: request.body['message'], type: MessageType.success);
      getData();
    } else {
      showMessage(message: request.body['message'], type: MessageType.error);
    }
  }

  Future<void> getData() async {
    final request = await service.getRequestMovie(token);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      movieModel = RequestMovieModel.fromJson(request.body);
      change(null, status: RxStatus.success());
    } else {
      showMessage(message: request.body['message'], type: MessageType.error);
    }
  }
}
