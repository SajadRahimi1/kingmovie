import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart' show TextEditingController, debugPrint;
import 'package:get/get.dart';
import 'package:king_movie/models/home_model.dart' as user_model;
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/constants/singleton_class.dart';
import 'package:king_movie/core/services/message_service.dart';
import 'package:king_movie/core/services/movie_service.dart' as movie_service;
import 'package:king_movie/core/services/watch_service.dart' as watch_service;
import 'package:king_movie/core/services/comment_service.dart'
    as comment_service;
import 'package:king_movie/models/movie_model.dart';
import 'package:king_movie/views/movie_detail/screens/play_movie_screen.dart';
import 'package:king_movie/views/movie_detail/screens/screen_shot_screen.dart';
import 'package:king_movie/views/movie_detail/widgets/confirm_button.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MovieViewModel extends GetxController with StateMixin {
  MovieViewModel(this.movieId);
  final String movieId;
  MovieModel? movieModel;
  RxBool isInitialVideo = false.obs, isBookmarked = false.obs;
  RxInt commentUpdate = 1.obs;
  final TextEditingController commentController = TextEditingController();
  Rx<String> replyId = "".obs;
  Timer? timer;
  int? movieDuration;

  late final player = Player(
      configuration: const PlayerConfiguration(logLevel: MPVLogLevel.debug))
    ..stream.log.listen((event) {
      debugPrint(event.toString());
    });
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player,
      configuration: const VideoControllerConfiguration(
          // enableHardwareAcceleration: false,
          ));

  final AutoScrollController pageScrollController = AutoScrollController();
  SubtitleViewConfiguration subtitleViewConfiguration =
      const SubtitleViewConfiguration();

  final GetStorage getStorage = GetStorage();
  String token = '';
  bool isSeek = false;
  String moviePlayingId = '';
  int savedTimer = -1;

  @override
  void onInit() async {
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
    await player.dispose();
  }

  Future<void> getData({bool? isReload}) async {
    fillToken();
    if (isReload ?? false) {
      change(null, status: RxStatus.loading());
    }
    final request = await movie_service.getMovie(token, movieId);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      movieModel = MovieModel.fromJson(request.body);
      isBookmarked.value = movieModel?.data?.watch == 'true';
      if (isReload ?? false) {
        SingletonClass.instance.user =
            user_model.User.fromJson(request.body['user']);
      }
      change(null, status: RxStatus.success());
    } else {
      showMessage(message: request.body['message'], type: MessageType.error);
      change(null, status: RxStatus.error(request.body['message']));
    }
  }

  Future<void> initTrailer(String? downloadLink) async {
    DownloadList downloadList = DownloadList(link: downloadLink);
    isSeek = await Get.defaultDialog<bool>(
          title: "پخش کننده",
          middleText: "با کدوم پخش کننده میخواهید پخش شود؟",
          confirm: const ConfirmButton(
            text: "پخش کننده کینگ مووی",
            statusOnClick: true,
          ),
          cancel: const ConfirmButton(text: "باقی پخش کننده ها"),
        ) ??
        true;

    if (isSeek) {
      Get.to(() => PlayMovieScreen(
            downloadList: downloadList,
            subtitleViewConfiguration: subtitleViewConfiguration,
          ));
      return;
    } else {
      AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        type: "video/*",
        data: downloadList.link,
      );
      await intent.launch();
    }
  }

  Future<void> addFavorite() async {
    final request = await watch_service.addFavorite(token, movieId);
    showMessage(
        message: request.body['message'],
        type: request.body['error'] == 'false'
            ? MessageType.success
            : MessageType.error);
    if (request.body['error'] == 'false') {
      // reverse bookmark value
      isBookmarked.value = !isBookmarked.value;
    }
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
      if (url?.link?.split('?').first.split('.').last == 'jpg' ||
          url?.link?.split('?').first.split('.').last == 'png') {
        Get.to(() => ScreenShotScreen(src: url?.link));
        return;
      }
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
        await intent.launch().then((value) => null);
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
      await getData();
      commentUpdate.value++;
    } else if (request.statusCode == 500) {
      networkErrorMessage();
    } else {
      showMessage(
          title: 'خطا',
          message: request.body['message'],
          type: MessageType.error);
    }
  }

  Future<void> choosePlayer(DownloadList? downloadList) async {
    isSeek = await Get.defaultDialog<bool>(
          title: "پخش کننده",
          middleText: "با کدوم پخش کننده میخواهید پخش شود؟",
          confirm: const ConfirmButton(
            text: "پخش کننده کینگ مووی",
            statusOnClick: true,
          ),
          cancel: const ConfirmButton(text: "باقی پخش کننده ها"),
        ) ??
        true;

    if (isSeek) {
      Get.to(() => PlayMovieScreen(
            downloadList: downloadList,
            subtitleViewConfiguration: subtitleViewConfiguration,
          ));
      return;
    } else {
      AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        type: "video/*",
        data: downloadList?.link,
      );
      await intent.launch();
    }
  }

  void fillToken() {
    if (token.isEmpty) token = getStorage.read('token') ?? "";
  }
}
