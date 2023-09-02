import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';

Future<Response<dynamic>> requestMovie(String token,String id) async {
 EasyLoading.show(
    status: 'در حال ارسال',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  final FormData formData = FormData({'userSalt': token, 'value': id});
  var returnData =  await getConnect.post(newRequestUrl, formData).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;;
}

Future<Response<dynamic>> getRequestMovie(String token) async {
  final FormData formData = FormData({'userSalt': token, });
  return await getConnect.post(movieRequestsUrl, formData);
}
