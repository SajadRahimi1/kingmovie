import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/ticket_service.dart' as service;
import 'package:king_movie/models/ticket_model.dart';

class TicketViewModel extends GetxController with StateMixin {
  final GetStorage getStorage = GetStorage();
  String token = "", ticketText = '', ticketTitle = '';
  RxString ticketImage = "".obs;
  TicketModel? ticketModel;
  RxBool isClickNew = false.obs;

  @override
  void onInit() async {
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
        token: token,
        text: ticketText,
        title: ticketTitle,
        image: ticketImage.value);
    if (request.statusCode == 200 && request.body['error'] == "false") {
      ticketModel = TicketModel.fromJson(request.body);
      isClickNew.value = false;
      await getData();
    } else {
      networkErrorMessage();
    }
  }

  Future<void> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (image != null) {
      ticketImage.value = image.path;
    }
  }
}
