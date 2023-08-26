import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/movie_service.dart';
import 'package:king_movie/models/movie_model.dart';

class MovieViewModel extends GetxController with StateMixin {
  MovieViewModel(this.movieId);
  final String movieId;
  MovieModel? movieModel;

  final GetStorage getStorage = GetStorage();
  String token = '';

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token');
    await getData();
  }

  Future<void> getData() async {
    final request = await getMovie(token, movieId);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      movieModel = MovieModel.fromJson(request.body);
      change(null, status: RxStatus.success());
    } else {
      showMessage(message: request.body['message'], type: MessageType.error);
      change(null, status: RxStatus.error(request.body['message']));
    }
  }
}
