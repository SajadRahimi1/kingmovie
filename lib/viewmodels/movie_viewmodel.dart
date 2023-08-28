import 'package:flutter/material.dart' show ScrollController, Curves;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/movie_service.dart';
import 'package:king_movie/models/movie_model.dart';
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

  final GetStorage getStorage = GetStorage();
  String token = '';



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
    player.dispose();
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
      await player.open(Media(url));

      isInitialVideo.value = true;
      pageScrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
    }
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
