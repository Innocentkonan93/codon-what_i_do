import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerBar extends StatefulWidget {
  const PlayerBar({
    required this.musicFile,
    Key? key,
  }) : super(key: key);

  final File musicFile;

  @override
  State<PlayerBar> createState() => _PlayerBarState();
}

class _PlayerBarState extends State<PlayerBar> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    setAudio();
    //listen to audioplayer state
    listen();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds);
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  void listen() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) {
        return;
      }
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    // listen the duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      if (!mounted) {
        return;
      }
      setState(() {
        duration = newDuration;
      });
    });

// listen the audio position

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      if (!mounted) {
        return;
      }
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    // final result = await FilePicker.platform.pickFiles();

    if (widget.musicFile != null) {
      final file = File(widget.musicFile.path);

      audioPlayer.setUrl(file.path, isLocal: true);
      print(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.56),
        boxShadow: [],
        // gradient: const LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   stops: [0.3, 0.6, 0.9],
        //   colors: [
        //     Colors.black12,
        //     Colors.transparent,
        //     Colors.black12,
        //   ],
        // ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      'Instrumental.mp3',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Flexible(
                  child: SliderTheme(
                    data: const SliderThemeData(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                      thumbColor: Colors.white,
                    ),
                    child: Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (val) async {
                        final position = Duration(seconds: val.toInt());
                        await audioPlayer.seek(position);

                        //
                        await audioPlayer.resume();
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(position),
                      // "0:0",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      "${duration.inMinutes}: ${duration.inSeconds}",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 17,
            backgroundColor: Colors.white,
            child: TextButton(
              onPressed: () async {
                if (isPlaying) {
                  print('play');
                  await audioPlayer.pause();
                } else {
                  await audioPlayer.resume();
                }
              },
              child: Center(
                child: isPlaying
                    ? SvgPicture.asset(
                        'assets/icons/pause.svg',
                        color: Colors.black,
                        height: 20,
                        width: 20,
                      )
                    : SvgPicture.asset(
                        'assets/icons/play.svg',
                        color: Colors.black,
                        height: 20,
                        width: 20,
                      ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 17,
            backgroundColor: Colors.white,
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/rotate-cw.svg',
                color: Colors.black,
                height: 20,
                width: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
