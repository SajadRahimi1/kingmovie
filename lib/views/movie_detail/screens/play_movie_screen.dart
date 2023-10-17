import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:king_movie/models/movie_model.dart';
import 'package:king_movie/viewmodels/play_movie_viewmodel.dart';
import 'package:king_movie/views/movie_detail/widgets/setting_bottom_sheet.dart';
import 'package:king_movie/views/movie_detail/widgets/top_video_widget.dart';
import 'package:media_kit_video/media_kit_video.dart';

class PlayMovieScreen extends StatefulWidget {
  const PlayMovieScreen(
      {super.key,
      required this.downloadList,
      required this.subtitleViewConfiguration});
  final DownloadList? downloadList;
  final SubtitleViewConfiguration subtitleViewConfiguration;

  @override
  State<PlayMovieScreen> createState() => _PlayMovieScreenState();
}

class _PlayMovieScreenState extends State<PlayMovieScreen> {
  late PlayMovieViewModel controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    controller = Get.put(PlayMovieViewModel(widget.downloadList));
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.only(bottom: 5),
        child: AspectRatio(
            aspectRatio: 16 / 8,
            child: MaterialVideoControlsTheme(
                normal: MaterialVideoControlsThemeData(
                    // Modify theme options:
                    buttonBarButtonSize: 24.0,
                    buttonBarButtonColor: Colors.white,
                    // Modify top button bar:
                    topButtonBar: [
                      const Spacer(),
                      SubtitleWidget(player: controller.player),
                      AudioWidget(player: controller.player),
                      IconButton(
                          onPressed: () async {
                            TextStyle? subtitleStyle =
                                await showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        const SettingBottomSheet());
                            if (subtitleStyle != null) {
                              controller.subtitleViewConfiguration.value =
                                  SubtitleViewConfiguration(
                                      style: subtitleStyle);
                            }
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )),
                    ]),
                fullscreen: MaterialVideoControlsThemeData(
                  // Modify theme options:
                  displaySeekBar: true,
                  shiftSubtitlesOnControlsVisibilityChange: true,

                  topButtonBar: [
                    const Spacer(),
                    SubtitleWidget(player: controller.player),
                    AudioWidget(player: controller.player),
                  ],
                  automaticallyImplySkipNextButton: false,
                  automaticallyImplySkipPreviousButton: false,
                ),
                child: Video(
                    controller: controller.controller,
                    subtitleViewConfiguration:
                        widget.subtitleViewConfiguration))),
      ),
    );
  }
}
