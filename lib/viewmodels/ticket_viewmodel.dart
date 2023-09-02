import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/ticket_service.dart' as service;
import 'package:king_movie/ticket_model.dart';

class TicketViewModel extends GetxController with StateMixin {
  final GetStorage getStorage = GetStorage();
  String token = "", ticketText = '', ticketTitle = '';
  TicketModel? ticketModel;
  RxBool isClickNew = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token') ?? '';
    await getData();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    final request = await service.getTickets(token);
    if (request.statusCode == 200 && request.body['error'] == "false") {
      ticketModel = TicketModel.fromJson(request.body);
      change(null, status: RxStatus.success());
    }
  }

  Future<void> newTicket() async {
    final request = await service.newTicket(
        token: token, text: ticketText, title: ticketTitle);
    if (request.statusCode == 200 && request.body['error'] == "false") {
      ticketModel = TicketModel.fromJson(request.body);
      isClickNew.value = false;
      await getData();
    } else {
      networkErrorMessage();
    }
  }
}
