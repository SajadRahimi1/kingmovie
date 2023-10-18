import 'package:flutter_easyloading/flutter_easyloading.dart';
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

Future<void> seenAlert({
  String? token,
}) async {
  final FormData formData = FormData({
    'userSalt': token,
  });
  EasyLoading.show(
    status: 'در حال اپدیت',
  ).timeout(const Duration(seconds: 25), onTimeout: () {
    EasyLoading.dismiss();
  });
  await getConnect
      .post(seenAlertUrl, formData)
      .timeout(const Duration(seconds: 25), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
}
