import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';

Future<Response<dynamic>> getMovie(String token, String id) async {
  final FormData formData = FormData({'userSalt': token, 'id': id});
  return await getConnect.post(getMovieUrl, formData);
}

Future<Response<dynamic>> getNewMovies(
    int page, bool isMovie, bool? dub) async {
  final FormData formData = FormData(
      {'way': isMovie ? 0 : 1, 'page': page, 'double': dub == null ? 0 : 1});
  return await getConnect.post(searchUrl, formData);
}

