import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:king_movie/views/movie_detail/widgets/controll_overlay.dart';

typedef OnStopRecordingCallback = void Function(String);

class VlcPlayerWithControls extends StatefulWidget {
  final VlcPlayerController controller;
  final bool showControls;
  final OnStopRecordingCallback? onStopRecording;
  final void Function()? onFullScreenTap;

  const VlcPlayerWithControls({
    Key? key,
    required this.controller,
    this.showControls = true,
    this.onStopRecording,
    this.onFullScreenTap,
  }) : super(key: key);

  @override
  VlcPlayerWithControlsState createState() => VlcPlayerWithControlsState();
}

class VlcPlayerWithControlsState extends State<VlcPlayerWithControls>
    with AutomaticKeepAliveClientMixin {
  static const _playerControlsBgColor = Colors.black87;
  static const _numberPositionOffset = 8.0;
  static const _recordingPositionOffset = 10.0;
  static const _positionedBottomSpace = 7.0;
  static const _positionedRightSpace = 3.0;
  static const _overlayWidth = 100.0;
  static const _elevation = 4.0;
  static const _aspectRatio = 16 / 9;

  final double initSnapshotRightPosition = 10;
  final double initSnapshotBottomPosition = 10;

  late VlcPlayerController _controller;

  //
  OverlayEntry? _overlayEntry;

  //
  double sliderValue = 0.0;
  double volumeValue = 50;
  String position = '';
  String duration = '';
  int numberOfCaptions = 0;
  int numberOfAudioTracks = 0;
  bool validPosition = false;

  double recordingTextOpacity = 0;
  DateTime lastRecordingShowTime = DateTime.now();
  bool isRecording = false;

  //
  List<double> playbackSpeeds = [0.5, 1.0, 2.0];
  int playbackSpeedIndex = 1;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(listener);
  }

  @override
  void dispose() {
    _controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    if (!mounted) return;
    //
    if (_controller.value.isInitialized) {
      final oPosition = _controller.value.position;
      final oDuration = _controller.value.duration;
      if (oDuration.inHours == 0) {
        final strPosition = oPosition.toString().split('.').first;
        final strDuration = oDuration.toString().split('.').first;
        setState(() {
          position =
              "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
          duration =
              "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
        });
      } else {
        setState(() {
          position = oPosition.toString().split('.').first;
          duration = oDuration.toString().split('.').first;
        });
      }
      setState(() {
        validPosition = oDuration.compareTo(oPosition) >= 0;
        sliderValue = validPosition ? oPosition.inSeconds.toDouble() : 0;
      });
      setState(() {
        numberOfCaptions = _controller.value.spuTracksCount;
        numberOfAudioTracks = _controller.value.audioTracksCount;
      });
      // update recording blink widget
      if (_controller.value.isRecording && _controller.value.isPlaying) {
        if (DateTime.now().difference(lastRecordingShowTime).inSeconds >= 1) {
          setState(() {
            lastRecordingShowTime = DateTime.now();
            recordingTextOpacity = 1 - recordingTextOpacity;
          });
        }
      } else {
        setState(() => recordingTextOpacity = 0);
      }
      // check for change in recording state
      if (isRecording != _controller.value.isRecording) {
        setState(() => isRecording = _controller.value.isRecording);
        if (!isRecording) {
          if (widget.onStopRecording != null) {
            widget.onStopRecording!(_controller.value.recordPath);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: widget.showControls,
            child: Container(
              width: double.infinity,
              color: _playerControlsBgColor,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            tooltip: 'Get Subtitle Tracks',
                            icon: const Icon(Icons.closed_caption),
                            color: Colors.white,
                            onPressed: _getSubtitleTracks,
                          ),
                          Positioned(
                            top: _numberPositionOffset,
                            right: _numberPositionOffset,
                            child: IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 2,
                                ),
                                child: Text(
                                  '$numberOfCaptions',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          IconButton(
                            tooltip: 'Get Audio Tracks',
                            icon: const Icon(Icons.audiotrack),
                            color: Colors.white,
                            onPressed: _getAudioTracks,
                          ),
                          Positioned(
                            top: _numberPositionOffset,
                            right: _numberPositionOffset,
                            child: IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 2,
                                ),
                                child: Text(
                                  '$numberOfAudioTracks',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.timer),
                            color: Colors.white,
                            onPressed: _cyclePlaybackSpeed,
                          ),
                          Positioned(
                            bottom: _positionedBottomSpace,
                            right: _positionedRightSpace,
                            child: IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 2,
                                ),
                                child: Text(
                                  '${playbackSpeeds.elementAt(playbackSpeedIndex)}x',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: Colors.black,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Center(
                    child: VlcPlayer(
                      controller: _controller,
                      aspectRatio: _aspectRatio,
                      placeholder:
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  Positioned(
                    top: _recordingPositionOffset,
                    left: _recordingPositionOffset,
                    child: AnimatedOpacity(
                      opacity: recordingTextOpacity,
                      duration: const Duration(seconds: 1),
                      child: const Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.circle, color: Colors.red),
                          SizedBox(width: 5),
                          Text(
                            'REC',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ControlsOverlay(controller: _controller),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.showControls,
            child: ColoredBox(
              color: _playerControlsBgColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: _controller.value.isPlaying
                        ? const Icon(Icons.pause_circle_outline)
                        : const Icon(Icons.play_circle_outline),
                    onPressed: _togglePlaying,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          position,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            activeColor: Colors.redAccent,
                            inactiveColor: Colors.white70,
                            value: sliderValue,
                            min: 0.0,
                            max: (!validPosition &&
                                    _controller.value.duration == null)
                                ? 1.0
                                : _controller.value.duration.inSeconds
                                    .toDouble(),
                            onChanged:
                                validPosition ? _onSliderPositionChanged : null,
                          ),
                        ),
                        Text(
                          duration,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.fullscreen),
                      color: Colors.white,
                      // ignore: no-empty-block
                      onPressed: widget.onFullScreenTap),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _cyclePlaybackSpeed() async {
    playbackSpeedIndex++;
    if (playbackSpeedIndex >= playbackSpeeds.length) {
      playbackSpeedIndex = 0;
    }

    return _controller
        .setPlaybackSpeed(playbackSpeeds.elementAt(playbackSpeedIndex));
  }

  Future<void> _togglePlaying() async {
    _controller.value.isPlaying
        ? await _controller.pause()
        : await _controller.play();
  }

  void _onSliderPositionChanged(double progress) {
    setState(() {
      sliderValue = progress.floor().toDouble();
    });
    //convert to Milliseconds since VLC requires MS to set time
    _controller.setTime(sliderValue.toInt() * Duration.millisecondsPerSecond);
  }

  Future<void> _getSubtitleTracks() async {
    // if (!_controller.value.isPlaying) return;

    final subtitleTracks = await _controller.getSpuTracks();
    //
    if (subtitleTracks.isNotEmpty) {
      if (!mounted) return;
      final int? selectedSubId = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Subtitle'),
            content: SizedBox(
              width: double.maxFinite,
              height: 250,
              child: ListView.builder(
                itemCount: subtitleTracks.keys.length + 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      index < subtitleTracks.keys.length
                          ? subtitleTracks.values.elementAt(index).toString()
                          : 'Disable',
                    ),
                    onTap: () {
                      Navigator.pop(
                        context,
                        index < subtitleTracks.keys.length
                            ? subtitleTracks.keys.elementAt(index)
                            : -1,
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      );
      if (selectedSubId != null) await _controller.setSpuTrack(selectedSubId);
    }
  }

  Future<void> _getAudioTracks() async {
    // if (!_controller.value.isPlaying) return;

    final audioTracks = await _controller.getAudioTracks();
    //
    if (audioTracks.isNotEmpty) {
      if (!mounted) return;
      final int? selectedAudioTrackId = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Audio'),
            content: SizedBox(
              width: double.maxFinite,
              height: 250,
              child: ListView.builder(
                itemCount: audioTracks.keys.length + 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      index < audioTracks.keys.length
                          ? audioTracks.values.elementAt(index).toString()
                          : 'Disable',
                    ),
                    onTap: () {
                      Navigator.pop(
                        context,
                        index < audioTracks.keys.length
                            ? audioTracks.keys.elementAt(index)
                            : -1,
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      );
      if (selectedAudioTrackId != null) {
        await _controller.setAudioTrack(selectedAudioTrackId);
      }
    }
  }
}
