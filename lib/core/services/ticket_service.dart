import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';

Future<Response<dynamic>> getTickets(String token) async {
  FormData formData = FormData({'userSalt': token});
  return getConnect.post(ticketUrl, formData);
}

Future<Response<dynamic>> newTicket(
    {required String token,
    required String title,
    required String text}) async {
  EasyLoading.show(
    status: 'در حال ارسال',
  ).timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
  });
  FormData formData =
      FormData({'userSalt': token, 'title': title, 'text': text});
  var returnData = await getConnect
      .post(newTicketUrl, formData)
      .timeout(const Duration(seconds: 5), onTimeout: () {
    EasyLoading.dismiss();
    return const Response(statusCode: 500);
  });
  EasyLoading.dismiss();
  return returnData;
}

Future<Response<dynamic>> getTicketMessage(
    {required String code, required String token}) async {
  FormData formData = FormData({'userSalt': token, 'code': code});
  return await getConnect.post(ticketMessageUrl, formData);
}
