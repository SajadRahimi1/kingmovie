import 'package:get/get.dart';
import 'package:king_movie/core/services/search_service.dart';
import 'package:king_movie/models/search_model.dart';

class SearchViewModel extends GetxController with StateMixin {
  SearchViewModel(this.text);
  final String text;
  int page = 1;

  SearchModel? searchModel;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await search();
  }

  Future<void> search() async {
    final request = await simpleSearch(searchText: text, page: page);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      if (page == 1) {
        searchModel = SearchModel.fromJson(request.body);
        change(null, status: RxStatus.success());
      } else {
        final SearchModel newPageModel = SearchModel.fromJson(request.body);
        newPageModel.data?.dataList?.forEach((element) {
          searchModel?.data?.dataList?.add(element);
        });
        change(null, status: RxStatus.success());
      }
    }
  }
}