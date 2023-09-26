import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
            builder: (context) => ListView(
                  children: List.generate(
                      subtitles.length + 1,
                      (index) => ListTile(
                            onTap: () async {
                              print("tap");
                              if (index == subtitles.length) {
                                var pickedTrack = await pickSubtitle();
                                if (pickedTrack != null) {
                                  try {
                                    subtitles.add(pickedTrack);
                                  } catch (_) {}
                                  Navigator.of(context).pop(pickedTrack);
                                }
                              } else {
                                Navigator.of(context).pop(subtitles[index]);
                              }
                            },
                            title: Text(index == subtitles.length
                                ? 'باز کردن زیرنویس'
                                : subtitles[index].title ??
                                    "زیرنویس ${index + 1}".toPersianDigit()),
                            leading: index == subtitles.length
                                ? const SizedBox()
                                : subtitles[index].id ==
                                        player.state.track.subtitle.id
                                    ? const Icon(Icons.done)
                                    : const SizedBox(),
                          )),
                )) as SubtitleTrack?;
        if (trackSelected != null) {
          await player.setSubtitleTrack(trackSelected);
        }
      },
      icon: const Icon(Icons.subtitles),
    );
  }

  Future<SubtitleTrack?> pickSubtitle() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['srt', 'vvt']);
    if (result != null && result.files.first.path != null) {
      String data = await File(result.files.first.path ?? "").readAsString();
      SubtitleTrack track =
          SubtitleTrack.data(data, title: result.files.first.name);
      return track;
      // player.setSubtitleTrack();
    }
    return null;
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
        audios = player.state.tracks.audio;
        // .where((element) => element.title != null)
        // .toList();
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
                            title:
                                Text(audios[index].title ?? "صوت ${index + 1}"),
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
