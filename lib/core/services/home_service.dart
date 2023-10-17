import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';

Future<Response<dynamic>> homeService([String? token]) async {
  final FormData formData = FormData({'userSalt': token});
  return await getConnect.post(homeUrl, formData);
}

Future<Response<dynamic>> tableService({String? token, String? date}) async {
  final FormData formData = FormData({'userSalt': token, 'table': date});
  return await getConnect.post(tableUrl, formData);
}

Future<Response<dynamic>> seenAlert({String? token,}) async {
  final FormData formData = FormData({'userSalt': token, });
  return await getConnect.post(seenAlertUrl, formData);
}
