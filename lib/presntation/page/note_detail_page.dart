import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:whai_i_do/data/Services/AdService.dart';
import 'package:whai_i_do/data/cubit/theme_cubit.dart';
import 'package:whai_i_do/presntation/widget/edit_police.dart';
import 'package:whai_i_do/presntation/widget/new_reminder_form.dart';
import '../../data/Models/Note.dart';
import '../../data/Database/note_database.dart';

import 'edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  // ignore: use_key_in_widget_constructors
  const NoteDetailPage({required this.noteId});

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage>
    with TickerProviderStateMixin {
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  AnimationController? controller;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  FocusNode focusNode = FocusNode();
  Note? note;
  bool isLoading = false;
  double fontSize = 18;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      // adUnitId: BannerAd.testAdUnitId,
      adUnitId: AdService.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          _isBottomBannerAdLoaded = true;
        });
      }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print(error);
      }),
    );
    _bottomBannerAd.load();
  }

  @override
  void initState() {
    _createBottomBannerAd();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    controller!.lowerBound;
    refreshNote();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    _bottomBannerAd.dispose();
    super.dispose();
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    note = await NoteDatabase.instance.readNote(widget.noteId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    bool isDark = themeCubit.isDark;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Scaffold(
            // backgroundColor: Colors.blueGrey[900],
            appBar: AppBar(
              title: const Text(""),
              // iconTheme: const IconThemeData(color: Colors.white),
              // backgroundColor: Colors.blueGrey[900],
              elevation: 0.0,

              actions: [
                CircleAvatar(
                  backgroundColor:
                      !isDark ? Colors.white : Colors.blueGrey[900],
                  child: IconButton(
                    tooltip: "Modifier",
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => EditNotePage(note!),
                        ),
                      );
                      print(result);
                      if (result == true) {
                        refreshNote();
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.orange,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor:
                      !isDark ? Colors.white : Colors.blueGrey[900],
                  child: IconButton(
                    tooltip: "Supprimer",
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                height: 180,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Suppression...',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.red[900],
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Vous confirmez l\'action ?',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // alignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Annuler',
                                            style: TextStyle(
                                                color: Colors.red[900]),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await NoteDatabase.instance
                                                .deleteNote(note!)
                                                .then((value) {
                                              Navigator.pop(context, false);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor:
                      !isDark ? Colors.white : Colors.blueGrey[900],
                  child: PopupMenuButton<String>(
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.timer, color: Colors.cyan),
                              SizedBox(width: 10),
                              Text(
                                'Ajouter un rappel',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            print("rappel");
                            refreshNote();
                          },
                          value: "rappel",
                        ),
                        PopupMenuItem(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.font_download_outlined,
                                color: Colors.cyan,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Modifier police',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            print("police");
                            refreshNote();
                          },
                          value: "police",
                        ),
                      ];
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 2.0,
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.green,
                    ),
                    enableFeedback: true,
                    offset: const Offset(-10.0, kToolbarHeight),
                    onSelected: (value) async {
                      if (value.isNotEmpty && value == "rappel") {
                        showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          elevation: 10,
                          backgroundColor: isDark ? Colors.blueGrey[900] : null,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          context: context,
                          builder: (context) => NewreminderForm(note: note!),
                        );
                      }
                      if (value.isNotEmpty && value == "police") {
                        final fontS = await showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          backgroundColor: isDark ? Colors.blueGrey[900] : null,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          context: context,
                          builder: (context) => EditPolice(fontSize),
                        );
                        setState(() {
                          fontSize = fontS;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: Column(
              children: [
                // const PlayerWidget(),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: note?.isImportant == true
                              ? Colors.orange[300]
                              : note?.isUrgent == true
                                  ? Colors.red[300]
                                  : Colors.cyan[200],
                          // ? const Color(0XFFF3F391)
                          // borderRadius:
                          //     const BorderRadius.vertical(bottom: Radius.circular(12)),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 5),
                                color: Colors.black45,
                                spreadRadius: 2,
                                blurRadius: 20)
                          ]),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              30,
                              (index) {
                                if (index.isOdd) {
                                  return Container(
                                    height: 1,
                                    width: 4,
                                    color: !isDark
                                        ? Colors.grey[50]
                                        : Colors.blueGrey[900],
                                  );
                                }
                                return CircleAvatar(
                                  radius: 7,
                                  backgroundColor: !isDark
                                      ? Colors.grey[200]
                                      : Colors.blueGrey[900],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : GestureDetector(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        // padding: const EdgeInsets.all(12.0),
                                        // physics: const NeverScrollableScrollPhysics(),
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              if (DateTime.now().isBefore(
                                                  note!.reminderDate!))
                                                const Icon(
                                                  Icons.alarm,
                                                  size: 15,
                                                  color: Colors.black87,
                                                ),
                                              Spacer(),
                                              Text(
                                                "Créée le " +
                                                    DateFormat("d.M.yyyy ")
                                                        .format(
                                                            note!.createdTime)
                                                        .toString(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.black38,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                note!.title,
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              note!.description + "\n\n\n\n",
                                              style: GoogleFonts.quicksand(
                                                fontSize: fontSize,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _isBottomBannerAdLoaded
                ? SizedBox(
                    height: _bottomBannerAd.size.height.toDouble(),
                    width: _bottomBannerAd.size.width.toDouble(),
                    child: AdWidget(
                      ad: _bottomBannerAd,
                    ),
                  )
                : null,
            // bottomSheet: Container(
            //   color: !isDark ? Colors.white : Colors.blueGrey[900],
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   height: 80,
            //   width: double.infinity,
            //   child: Center(child: Text("publicité")),
            // ),
          );
  }
}

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    setAudio();
    //listen to audioplayer state
    if (mounted) {
      audioPlayer.onPlayerStateChanged.listen((state) {
        setState(() {
          isPlaying = state == PlayerState.PLAYING;
        });
      });

      // listen the duration
      audioPlayer.onDurationChanged.listen((newDuration) {
        setState(() {
          duration = newDuration;
        });
      });

// listen the audio position

      audioPlayer.onAudioPositionChanged.listen((newPosition) {
        setState(() {
          position = newPosition;
        });
      });
    }
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

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path!);

      audioPlayer.setUrl(file.path, isLocal: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.white12,
      child: Row(
        children: [
          Expanded(
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
          IconButton(
            onPressed: () async {
              if (isPlaying) {
                await audioPlayer.pause();
              } else {
                await audioPlayer.resume();
              }
            },
            icon: const CircleAvatar(
              child: Icon(Icons.play_arrow),
            ),
          )
        ],
      ),
    );
  }
}
