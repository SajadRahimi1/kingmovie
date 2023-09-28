import 'package:flutter_easyloading/flutter_easyloading.dart';
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


Future<Response<dynamic>> loadComment(String token, String id) async {
  EasyLoading.show(
    status: 'در حال ارسال',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  final FormData formData = FormData({'userSalt': token, 'id': id, 'limit':30});
  var returnData = await getConnect
      .post(loadCommentUrl, formData)
      .timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;
}
