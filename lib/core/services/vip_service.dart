import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';

Future<Response<dynamic>> buyVip(
    {required int pack, required String token}) async {
  EasyLoading.show(
    status: 'در حال ثبت',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  FormData formData = FormData({'pack': pack, 'userSalt': token});

  var returnData = await getConnect
      .post(
    buyVipUrl,
    formData,
  )
      .timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;
}
