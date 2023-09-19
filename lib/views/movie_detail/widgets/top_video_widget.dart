import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video_controls/media_kit_video_controls.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({super.key, required this.player});
  final Player player;

  @override
  Widget build(BuildContext context) {
    List<SubtitleTrack> subtitles = [];
    return MaterialCustomButton(
      onPressed: () async {
        subtitles = player.state.tracks.subtitle;
        // .where((element) => element.title != null)
        // .toList();
        SubtitleTrack? trackSelected = await showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            builder: (context) => Wrap(
                  children: List.generate(
                      subtitles.length,
                      (index) => ListTile(
                            onTap: () {
                              print("tap");
                              Navigator.of(context).pop(subtitles[index]);
                            },
                            title: Text(subtitles[index].title ??
                                "زیرنویس ${index + 1}".toPersianDigit()),
                            leading: subtitles[index].id ==
                                    player.state.track.subtitle.id
                                ? const Icon(Icons.done)
                                : const SizedBox(),
                          )),
                )) as SubtitleTrack?;
        print("closed");
        if (trackSelected != null) {
          await player.setSubtitleTrack(trackSelected);
        }
      },
      icon: const Icon(Icons.subtitles),
    );
  }
}

class AudioWidget extends StatelessWidget {
  const AudioWidget({super.key, required this.player});
  final Player player;

  @override
  Widget build(BuildContext context) {
    List<AudioTrack> audios = [];
    return MaterialCustomButton(
      onPressed: () async {
        audios = player.state.tracks.audio
            .where((element) => element.title != null)
            .toList();
        AudioTrack? trackSelected = await showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            builder: (context) => Wrap(
                  children: List.generate(
                      audios.length,
                      (index) => ListTile(
                            onTap: () {
                              Navigator.pop(context, audios[index]);
                            },
                            title: Text(audios[index].title ?? ""),
                            leading:
                                audios[index].id == player.state.track.audio.id
                                    ? const Icon(Icons.done)
                                    : const SizedBox(),
                          )),
                )) as AudioTrack?;
        if (trackSelected != null) {
          await player.setAudioTrack(trackSelected);
        }
      },
      icon: const Icon(Icons.audiotrack),
    );
  }
}
