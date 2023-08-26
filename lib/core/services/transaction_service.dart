import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';

Future<Response<dynamic>> getTransaction(String token) async {
  final FormData formData = FormData({'userSalt': token});
  return await getConnect.post(transactionUrl, formData);
  
}
