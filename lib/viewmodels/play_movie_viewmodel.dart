import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/models/movie_model.dart';
import 'package:king_movie/views/movie_detail/widgets/confirm_button.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class PlayMovieViewModel extends GetxController with StateMixin {
  PlayMovieViewModel(this.downloadList);
  RxBool isInitialVideo = false.obs;
  RxInt commentUpdate = 1.obs;
  Timer? timer;
  final DownloadList? downloadList;
  int? movieDuration;

  late final player = Player(
      configuration: const PlayerConfiguration(logLevel: MPVLogLevel.debug))
    ..stream.log.listen((event) {
      print(event.toString());
    });
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player,
      configuration: const VideoControllerConfiguration(
          // enableHardwareAcceleration: false,
          ));

  Rx<SubtitleViewConfiguration> subtitleViewConfiguration =
      const SubtitleViewConfiguration().obs;

  final GetStorage getStorage = GetStorage();
  String token = '';
  bool isSeek = false;
  String moviePlayingId = '';
  int savedTimer = -1;

  @override
  void onInit() async {
    super.onInit();
    await GetStorage.init();
    await initVideo();
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
        isSeek = false;
        await player.seek(Duration(seconds: movieDuration ?? 0));
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    if (timer != null) timer?.cancel();
    await player.dispose();
  }

  Future<void> initVideo() async {
    if (downloadList != null && downloadList?.link != null) {
      moviePlayingId = downloadList?.link ?? "";
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
      await player.open(Media(downloadList?.link ?? ""));
      isInitialVideo.value = true;
    }
  }

  void setSubStyle(SubtitleViewConfiguration config) =>
      subtitleViewConfiguration.value = config;
}
