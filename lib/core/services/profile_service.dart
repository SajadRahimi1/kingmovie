import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';
import 'package:king_movie/models/user_model.dart';

Future<Response<dynamic>> updateInformation(
    {required UserModel userModel}) async {
  FormData formData = FormData(userModel.toJson());

  return await getConnect.post(updateProfileUrl, formData, headers: {});
}