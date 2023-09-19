import 'package:get/get.dart';
import 'package:king_movie/core/services/ticket_service.dart';
import 'package:king_movie/models/ticket_message_model.dart';

class TicketMessageViewmModel extends GetxController with StateMixin {
  TicketMessageViewmModel({required this.code, required this.token});
  final String code, token;
  TicketMessageModel? model;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getData();
  }

  Future<void> getData() async {
    final request = await getTicketMessage(code: code, token: token);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      model = TicketMessageModel.fromJson(request.body);
      model?.data?.list = model?.data?.list?.reversed.toList();
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(request.body['message']));
    }
  }
   
  
}
