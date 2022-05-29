import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zoknot/models/note_model.dart';
import 'package:zoknot/widgets/custom_popup_menu.dart';

import '../../database/database.dart';
import '../../services/AdService.dart';
import '../../widgets/widgets.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({
    required this.noteId,
    Key? key,
  }) : super(key: key);

  final int noteId;

  static const routeName = '/note-screen';

  Route route() {
    return MaterialPageRoute(builder: (context) {
      return NoteScreen(noteId: noteId);
    });
  }

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final audioPlayer = AudioPlayer();
  late BannerAd _bottomBannerAd;
  NoteModel? note;
  File? musicFile;

  bool _isBottomBannerAdLoaded = false;
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
    refreshNote();
    super.initState();
  }

  @override
  void dispose() {
    _bottomBannerAd.dispose();
    super.dispose();
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    note = await NewNoteDatabase.instance.readNote(widget.noteId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              actions: [
                TextButton(
                  onPressed: () {},
                  child: SvgPicture.asset(
                    "assets/icons/edit-2.svg",
                    // color: Theme.of(context).colorScheme.primary,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  // onPressed: setAudio,
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();

                    if (result != null) {
                      setState(() {
                        musicFile = File(result.files.first.path!);
                        NewNoteDatabase.instance.updateNote(note!
                            .copyWith(noteFilePath: result.files.first.path));
                      });
                      refreshNote();
                    }
                  },

                  child: SvgPicture.asset(
                    "assets/icons/music.svg",
                    // color: Theme.of(context).colorScheme.primary,
                    color: note!.noteFilePath == ""
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                CustomPopuMenu(
                  note: note!,
                )
              ],
            ),
            body: Column(
              children: [
                // PlayerWidget(),
                if (note!.noteFilePath != "")
                  PlayerBar(musicFile: File(note!.noteFilePath!)),
                // if (musicFile != null) PlayerBar(musicFile: musicFile!),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    color: Color(int.parse(note!.noteColor)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(30, (index) {
                              if (index.isOdd) {
                                return Container(
                                  width: 3,
                                  // color: Colors.blueGrey[900],
                                );
                              }
                              return CircleAvatar(
                                radius: 7,
                                backgroundColor: Colors.blueGrey[900],
                              );
                            }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(note!.noteFilePath.toString()),
                          ),
                        ),
                      ],
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
          );
  }
}
