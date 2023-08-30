import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/transaction_service.dart';
import 'package:king_movie/models/transaction_model.dart';

class TransactionViewModel extends GetxController with StateMixin {
  final GetStorage getStorage = GetStorage();
  TransactionModel? transactionModel;
  String token = "";

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token') ?? '';
    await getData();
  }

  Future<void> getData() async {
    final request = await getTransaction(token);
    if (request.statusCode == 200 && request.body['error'] == "false") {
      transactionModel = TransactionModel.fromJson(request.body);
      change(null, status: RxStatus.success());
    }
  }
}
