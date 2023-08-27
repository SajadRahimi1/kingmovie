import 'package:flutter/material.dart' show ScrollController, Curves;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/full_screen_service.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/movie_service.dart';
import 'package:king_movie/models/movie_model.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class MovieViewModel extends GetxController with StateMixin {
  MovieViewModel(this.movieId);
  final String movieId;

  MovieModel? movieModel;
  RxBool isInitialVideo = false.obs;

  RxBool isPortrait = true.obs;

  final ScrollController pageScrollController = ScrollController();

  final GetStorage getStorage = GetStorage();
  String token = '';

  late VlcPlayerController vlcPlayerController;
  // BetterPlayerDataSource? betterPlayerDataSource;
  // late BetterPlayerController betterPlayerController;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token') ?? "";
    print('$token:$movieId');
    await getData();
  }

  @override
  void dispose() async {
    super.dispose();
    await vlcPlayerController.stopRendererScanning();
    await vlcPlayerController.dispose();
  }

  Future<void> getData() async {
    final request = await getMovie(token, movieId);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      movieModel = MovieModel.fromJson(request.body);
      change(null, status: RxStatus.success());
    } else {
      showMessage(message: request.body['message'], type: MessageType.error);
      change(null, status: RxStatus.error(request.body['message']));
    }
  }

  Future<void> initVideo(String? url) async {
    if (url != null) {
      try {
        if (isInitialVideo.value == true) isInitialVideo.value = false;
        vlcPlayerController = VlcPlayerController.network(url,
            hwAcc: HwAcc.auto, options: VlcPlayerOptions());
        isInitialVideo.value = true;
        pageScrollController.animateTo(0.0,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      } catch (e) {}
    }
    //   try {
    //     if (isInitialVideo.value) {
    //       isInitialVideo.value = false;
    //     }
    //     BetterPlayerDataSource createdDataSource =
    //         BetterPlayerDataSource.network(url,
    //             cacheConfiguration:
    //                 const BetterPlayerCacheConfiguration(useCache: true),
    //             useAsmsAudioTracks: true,
    //             useAsmsTracks: true,
    //             useAsmsSubtitles: true);

    //     betterPlayerDataSource = createdDataSource;

    //     pageScrollController.animateTo(0.0,
    //         duration: const Duration(milliseconds: 500), curve: Curves.ease);

    //     betterPlayerController = BetterPlayerController(
    //         BetterPlayerConfiguration(translations: [
    //           BetterPlayerTranslations(
    //               generalDefault: 'پیش فرض',
    //               generalNone: 'خالی',
    //               qualityAuto: 'خودکار',
    //               overflowMenuAudioTracks: 'انتخاب صوت',
    //               overflowMenuPlaybackSpeed: 'تنظیم سرعت',
    //               overflowMenuQuality: 'انتخاب کیفیت',
    //               overflowMenuSubtitles: 'انتخاب زیرنویس')
    //         ]),
    //         betterPlayerDataSource: betterPlayerDataSource);
    //     betterPlayerController.setAudioTrack(
    //         BetterPlayerAsmsAudioTrack(label: 'persian', url: url));
    //     print('audio= ${betterPlayerController.betterPlayerAsmsAudioTrack}');
    //     isInitialVideo.value = true;
    //   } catch (e) {}
    // }
  }

  Future<void> fullSrceen() async {
    if (isPortrait.value) {
      await forceLandscape();
      isPortrait.value = false;
      pageScrollController.animateTo(
          pageScrollController.position.maxScrollExtent/2,
          duration: const Duration(milliseconds: 100),
          curve: Curves.slowMiddle);
    } else {
      await forcePortrait();
      isPortrait.value = true;
    }
  }
}
