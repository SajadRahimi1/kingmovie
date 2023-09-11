import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';

Future<Response<dynamic>> likeComment(
    {required String way, required String id, required String token}) async {
  EasyLoading.show(
    status: 'در حال ثبت',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  FormData formData =
      FormData({'cat': 'comment', 'id': id, 'way': way, 'userSalt': token});

  var returnData = await getConnect
      .post(
    likeCommentUrl,
    formData,
  )
      .timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;
}

Future<Response<dynamic>> comment(
    {required String? parent,
    required String id,
    required String text,
    required String token}) async {
  EasyLoading.show(
    status: 'در حال ثبت',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  FormData formData = FormData(
      {'parent': (parent ?? "0"), 'id': id, 'text': text, 'userSalt': token});

  var returnData = await getConnect
      .post(
    commentUrl,
    formData,
  )
      .timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;
}
