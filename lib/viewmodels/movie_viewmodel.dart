import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart'
    show Colors, Curves, ScrollController, TextEditingController, TextStyle;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/movie_service.dart' as movie_service;
import 'package:king_movie/core/services/watch_service.dart' as watch_service;
import 'package:king_movie/core/services/comment_service.dart'
    as comment_service;
import 'package:king_movie/models/movie_model.dart';
import 'package:king_movie/views/movie_detail/widgets/confirm_button.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MovieViewModel extends GetxController with StateMixin {
  MovieViewModel(this.movieId);
  final String movieId;
  MovieModel? movieModel;
  RxBool isInitialVideo = false.obs;
  RxInt commentUpdate = 1.obs;
  final TextEditingController commentController = TextEditingController();
  Rx<String> replyId = "".obs;
  Timer? timer;
  int? movieDuration;

  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player,
      configuration: const VideoControllerConfiguration(
        enableHardwareAcceleration: false,
      ));

  final AutoScrollController pageScrollController = AutoScrollController();
  Rx<SubtitleViewConfiguration> subtitleViewConfiguration =
      const SubtitleViewConfiguration().obs;

  final GetStorage getStorage = GetStorage();
  String token = '';
  bool isSeek = false;
  String moviePlayingId = '';
  int savedTimer = -1;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await GetStorage.init();
    token = getStorage.read('token') ?? "";
    print('$token:$movieId');

    player.stream.position.listen((event) async {
      if (event.inSeconds > 10) {
        timer ??= Timer.periodic(const Duration(seconds: 3), (_) async {
          int playingSecond = player.state.position.inSeconds;
          if (savedTimer != playingSecond) {
            print(
                "moviePlayingId                                $moviePlayingId");
            await getStorage.write(
                moviePlayingId, player.state.position.inSeconds);
          }
        });
      }
      if (isSeek) {
        await player.seek(Duration(seconds: movieDuration ?? 0));
        isSeek = false;
      }
    });

    await getData();
  }

  @override
  void dispose() async {
    super.dispose();
    if (timer != null) timer?.cancel();
    player.dispose();
  }

  void setSubStyle(SubtitleViewConfiguration config) =>
      subtitleViewConfiguration.value =
          const SubtitleViewConfiguration(style: TextStyle(color: Colors.red));

  Future<void> getData() async {
    final request = await movie_service.getMovie(token, movieId);
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
      moviePlayingId = downloadList.link ?? "";
      moviePlayingId = moviePlayingId.split('/').last.split('?').first;
      movieDuration = getStorage.read(moviePlayingId);
      print("movie duration:                             $movieDuration");
      if (movieDuration != null) {
        isSeek = await Get.defaultDialog<bool>(
              title: "پخش از ادامه",
              middleText: "آیا میخواهید از ادامه پخش شود؟",
              confirm: const ConfirmButton(
                text: "بله",
                statusOnClick: true,
              ),
              cancel: const ConfirmButton(text: "خیر"),
            ) ??
            false;
      }
      await player.open(Media(downloadList.link ?? ""));
      isInitialVideo.value = true;

      pageScrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
    }
  }

  Future<void> initTrailer(String? downloadLink) async {
    if (downloadLink != null) {
      await player.open(Media(downloadLink));
      isInitialVideo.value = true;

      pageScrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
    }
  }

  Future<void> addFavorite() async {
    final request = await watch_service.addFavorite(token, movieId);
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
    return player.state.tracks.subtitle;
    // .where((element) => element.title != null)
    // .toList();
  }

  Future<void> openUrl(DownloadList? url) async {
    if (url?.link != null) {
      bool isInstalled = await DeviceApps.isAppInstalled('com.dv.adm');

      if (isInstalled) {
        final AndroidIntent intent = AndroidIntent(
          action: 'action_main',
          package: 'com.dv.adm',
          componentName: 'com.dv.adm.AEditor',
          arguments: <String, dynamic>{
            'android.intent.extra.TEXT': url?.link,
          },
        );
        await intent.launch().then((value) => null).catchError((e) => print(e));
      } else {
        launchUrlString(url?.link ?? "", mode: LaunchMode.externalApplication);
      }
    } else {
      showMessage(message: 'لینکی یافت نشد', type: MessageType.warning);
    }
  }

  Future<void> likeComment({required String id, required String way}) async {
    final request =
        await comment_service.likeComment(way: way, id: id, token: token);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      showMessage(message: 'با موفقیت ثبت شد', type: MessageType.success);
      var commentObject =
          movieModel?.data?.comment?.singleWhere((element) => element.id == id);
      if (commentObject != null) {
        if (way == 'like') {
          commentObject.like = (commentObject.like ?? 0) + 1;
        } else {
          commentObject.dislike = (commentObject.dislike ?? 0) + 1;
        }
        commentUpdate.value++;
      }
    } else if (request.statusCode == 500) {
      networkErrorMessage();
    } else {
      showMessage(
          title: 'خطا',
          message: request.body['message'],
          type: MessageType.error);
    }
  }

  Future<void> comment() async {
    final request = await comment_service.comment(
        parent: replyId.isEmpty ? null : replyId.value,
        id: movieId,
        text: commentController.text,
        token: token);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      commentController.clear();
      showMessage(message: request.body['message'], type: MessageType.success);
    } else if (request.statusCode == 500) {
      networkErrorMessage();
    } else {
      showMessage(
          title: 'خطا',
          message: request.body['message'],
          type: MessageType.error);
    }
  }
}
