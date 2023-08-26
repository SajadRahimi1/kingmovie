import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/ticker_service.dart';
import 'package:king_movie/ticket_model.dart';

class TicketViewModel extends GetxController with StateMixin {
  final GetStorage getStorage = GetStorage();
  String token = "";
  TicketModel? ticketModel;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token');
    await getData();
  }

  Future<void> getData() async {
    final request = await getTickets(token);
    if (request.statusCode == 200 && request.body['error'] == "false") {
      ticketModel = TicketModel.fromJson(request.body);
      change(null, status: RxStatus.success());
    }
  }
}
