import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';
import 'package:king_movie/models/signup_model.dart';

Future<Response<dynamic>> login(
    {required String email, required String password}) async {
  EasyLoading.show(
    status: 'در حال ارسال',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  FormData formData = FormData({'password': password, 'email': email});

  var returnData = await getConnect.post(loginUrl, formData,
      headers: {}).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;
}

Future<Response<dynamic>> forget(
    {required String email}) async {
  EasyLoading.show(
    status: 'در حال ارسال',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  FormData formData = FormData({ 'email': email});

  var returnData = await getConnect.post(forgetUrl, formData,
      headers: {}).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;
}

Future<Response<dynamic>> signup(
    {required SignupModel signupModel}) async {
  EasyLoading.show(
    status: 'در حال ارسال',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  FormData formData = FormData(signupModel.toJson());

  var returnData = await getConnect.post(signupUrl, formData,
      headers: {}).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;
}
