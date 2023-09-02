import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';
import 'package:king_movie/models/user_model.dart';

Future<Response<dynamic>> updateInformation(
    {required UserModel userModel}) async {
  EasyLoading.show(
    status: 'در حال اپدیت',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  FormData formData = FormData(userModel.toJson());

  var returnData = await getConnect.post(updateProfileUrl, formData,
      headers: {}).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;
}

Future<Response<dynamic>> updatePassword(
    {required String password, required String token}) async {
  EasyLoading.show(
    status: 'در حال ارسال',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  FormData formData = FormData(
      {'password': password, 'repassword': password, 'userSalt': token});

  var returnData = await getConnect.post(updatePasswordUrl, formData,
      headers: {}).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;
}
