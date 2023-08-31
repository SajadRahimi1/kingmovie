import 'dart:async';

import 'package:flutter/material.dart'
    show Colors, Curves, ScrollController, TextStyle;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/movie_service.dart' as service;
import 'package:king_movie/models/movie_model.dart';
import 'package:king_movie/views/movie_detail/widgets/confirm_button.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MovieViewModel extends GetxController with StateMixin {
  MovieViewModel(this.movieId);
  final String movieId;

  MovieModel? movieModel;
  RxBool isInitialVideo = false.obs;

  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player,
      configuration: const VideoControllerConfiguration(
        enableHardwareAcceleration: false,
      ));

  final ScrollController pageScrollController = ScrollController();
  Rx<SubtitleViewConfiguration> subtitleViewConfiguration =
      const SubtitleViewConfiguration().obs;

  final GetStorage getStorage = GetStorage();
  String token = '';
  bool isSeek = false;
  String moviePlayingId = '';

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token') ?? "";
    print('$token:$movieId');

    player.stream.position.listen((event) async {
      if (event.inSeconds > 10) {
        await getStorage.write(moviePlayingId, event.inMilliseconds);
      }
    });

    player.stream.position.listen((event) async {
      if (event.inSeconds == 1) {
        int? movieDuration = getStorage.read(moviePlayingId);
        if (movieDuration != null) {
          isSeek = true;
          if (isSeek) {
            print(movieDuration);
            await player
                .seek(Duration(milliseconds: movieDuration))
                .then((value) => isSeek = false);
          }
        }
      }
    });

    await getData();
  }

  @override
  void dispose() async {
    super.dispose();
    player.dispose();
  }

  void setSubStyle(SubtitleViewConfiguration config) =>
      subtitleViewConfiguration.value =
          const SubtitleViewConfiguration(style: TextStyle(color: Colors.red));

  Future<void> getData() async {
    final request = await service.getMovie(token, movieId);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      movieModel = MovieModel.fromJson(request.body);
      change(null, status: RxStatus.success());
    } else {
      showMessage(message: request.body['message'], type: MessageType.error);
      change(null, status: RxStatus.error(request.body['message']));
    }
  }

  Future<void> initVideo(DownloadList? downloadList) async {
    if (downloadList != null && downloadList.link != null) {
      int? movieDuration = getStorage.read(moviePlayingId);
      print(movieDuration);
      if (movieDuration != null) {
        await Get.defaultDialog(
          title: "پخش از ادامه",
          middleText: "آیا میخواهید از ادامه پخش شود؟",
          confirm: const ConfirmButton(text: "بله"),
          cancel: const ConfirmButton(text: "خیر"),
        );
      }
      await player.open(Media(downloadList.link ?? ""));
      moviePlayingId = downloadList.link ?? "";
      isInitialVideo.value = true;

      pageScrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
    }
  }

  Future<void> addFavorite() async {
    final request = await service.addFavorite(token, movieId);
    showMessage(
        message: request.body['message'],
        type: request.body['error'] == 'false'
            ? MessageType.success
            : MessageType.error);
  }

  List<AudioTrack> audios() {
    return player.state.tracks.audio
        .where((element) => element.title != null)
        .toList();
  }

  List<SubtitleTrack> subtitles() {
    return player.state.tracks.subtitle
        .where((element) => element.title != null)
        .toList();
  }
}
