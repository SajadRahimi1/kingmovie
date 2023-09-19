import 'package:flutter/material.dart' show ScrollController;
import 'package:get/get.dart';
import 'package:king_movie/core/services/search_service.dart' as service;
import 'package:king_movie/models/advance_search_model.dart';
import 'package:king_movie/models/search_model.dart';

class SearchViewModel extends GetxController with StateMixin {
  SearchViewModel(
    this.text, [
    this.advanceSearchModel,
    this.cast,
  ]);
  final AdvanceSearchModel? advanceSearchModel;
  final String text;
  final String? cast;
  int page = 1;
  bool isLastPage = false;
  final ScrollController scrollController = ScrollController();

  SearchModel? searchModel;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(() async {
      // end of scroll
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        page++;
        if (!isLastPage) {
          if (cast != null) {
            await castSearch();
          } else if (advanceSearchModel != null) {
            await advanceSearch();
          } else {
            await search();
          }
        }
      }
    });
    if (cast != null) {
      await castSearch();
    } else if (advanceSearchModel != null) {
      await advanceSearch();
    } else {
      await search();
    }
  }

  Future<void> search() async {
    final request = await service.simpleSearch(searchText: text, page: page);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      if (page == 1) {
        searchModel = SearchModel.fromJson(request.body);
        if (searchModel?.data?.dataList?.isEmpty ?? true) {
          isLastPage = true;
          return;
        }
        isLastPage = (searchModel?.data?.dataList?.length ?? 0) < 10;
        change(null, status: RxStatus.success());
      } else {
        final SearchModel newPageModel = SearchModel.fromJson(request.body);
        if (newPageModel.data?.dataList?.isEmpty ?? true) {
          isLastPage = true;
          return;
        }
        isLastPage = (newPageModel.data?.dataList?.length ?? 0) < 10;
        newPageModel.data?.dataList?.forEach((element) {
          searchModel?.data?.dataList?.add(element);
        });
        change(null, status: RxStatus.success());
      }
    }
  }

  Future<void> castSearch() async {
    final request = await service.castSearch(cast: cast ?? "", page: page);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      if (page == 1) {
        searchModel = SearchModel.fromJson(request.body);
        if (searchModel?.data?.dataList?.isEmpty ?? true) {
          isLastPage = true;
          return;
        }
        isLastPage = (searchModel?.data?.dataList?.length ?? 0) < 10;
        change(null, status: RxStatus.success());
      } else {
        final SearchModel newPageModel = SearchModel.fromJson(request.body);
        if (newPageModel.data?.dataList?.isEmpty ?? true) {
          isLastPage = true;
          return;
        }
        isLastPage = (newPageModel.data?.dataList?.length ?? 0) < 10;
        newPageModel.data?.dataList?.forEach((element) {
          searchModel?.data?.dataList?.add(element);
        });
        change(null, status: RxStatus.success());
      }
    }
  }

  Future<void> advanceSearch() async {
    final request = await service.advanceSearch(
        model: advanceSearchModel ?? AdvanceSearchModel(), page: page);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      if (page == 1) {
        searchModel = SearchModel.fromJson(request.body);
        if (searchModel?.data?.dataList?.isEmpty ?? true) {
          isLastPage = true;
          return;
        }
        isLastPage = (searchModel?.data?.dataList?.length ?? 0) < 10;
        change(null, status: RxStatus.success());
      } else {
        final SearchModel newPageModel = SearchModel.fromJson(request.body);
        if (newPageModel.data?.dataList?.isEmpty ?? true) {
          isLastPage = true;
          return;
        }
        isLastPage = (newPageModel.data?.dataList?.length ?? 0) < 10;
        newPageModel.data?.dataList?.forEach((element) {
          searchModel?.data?.dataList?.add(element);
        });
        change(null, status: RxStatus.success());
      }
    }
  }
}
