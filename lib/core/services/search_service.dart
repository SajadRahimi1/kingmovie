import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:king_movie/core/constants/url_constant.dart';
import 'package:king_movie/core/services/get_connect_service.dart';

Future<Response<dynamic>> simpleSearch(
    {required String searchText, int page = 1}) async {
  final FormData formData = FormData({'title': searchText, 'page': page});
  return await getConnect.post(searchUrl, formData);
}
