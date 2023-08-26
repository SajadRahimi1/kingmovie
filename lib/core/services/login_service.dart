import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';

Future<Response<dynamic>> login(
    {required String email, required String password}) async {
  FormData formData = FormData({'password': password, 'email': email});

  return await getConnect.post(loginUrl, formData, headers: {});
}
