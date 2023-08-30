import 'package:flutter/material.dart' show ScrollController;
import 'package:get/get.dart';
import 'package:king_movie/core/services/movie_service.dart' as service;
import 'package:king_movie/models/new_movie_model.dart';

class NewAllViewModel extends GetxController with StateMixin {
  NewAllViewModel({required this.isMovie, this.dub});
  final bool isMovie;
  final bool? dub;

  final ScrollController scrollController = ScrollController();

  NewMovieModel? movieModel;
  List<ListData> movieList = [];

  int page = 1;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    change(null, status: RxStatus.success());
    scrollController.addListener(() async {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        page++;
        await getNewMovie();
      }
    });
    await getNewMovie();
  }

  Future<void> getNewMovie() async {
    final request = await service.getNewMovies(page, isMovie, dub);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      movieModel = NewMovieModel.fromJson(request.body);
      movieList += movieModel?.data?.list ?? [];
      change(null, status: RxStatus.success());
    }
  }
}
