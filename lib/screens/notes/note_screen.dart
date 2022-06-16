import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zoknot/models/note_model.dart';
import 'package:zoknot/screens/notes/edit_note_screen.dart';
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
  bool isEditView = false;
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
    return isEditView
        ? EditNoteView(note: note!)

        // ! A review this part of code for later
        : isLoading
            ? Center(
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  // child: const CircularProgressIndicator.adaptive(),
                ),
              )
            : Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/x.svg",
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isEditView = true;
                        });
                      },
                      child: SvgPicture.asset(
                        "assets/icons/edit-2.svg",
                        // color: Theme.of(context).colorScheme.primary,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    TextButton(
                      // onPressed: setAudio,
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                            // allowedExtensions: ["3gp", "mp3"],
                            // type: FileType.custom,
                            );

                        if (result != null) {
                          setState(() {
                            musicFile = File(result.files.first.path!);
                            NewNoteDatabase.instance.updateNote(note!.copyWith(
                                noteFilePath: result.files.first.path));
                          });
                          refreshNote();
                        }
                      },

                      child: SvgPicture.asset(
                        "assets/icons/music.svg",
                        // color: Theme.of(context).colorScheme.primary,
                        color: note!.noteFilePath == ""
                            ? Theme.of(context).colorScheme.onBackground
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    CustomPopuMenu(
                      note: note!,
                    )
                  ],
                ),
                body: PhysicalModel(
                  elevation: 15,
                  shadowColor: Colors.black,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      // PlayerWidget(),
                      if (Platform.isAndroid && note!.noteFilePath != "")
                        PlayerBar(
                          musicFile: File(note!.noteFilePath!),
                        ),
                      if (Platform.isIOS && musicFile != null)
                        PlayerBar(musicFile: musicFile!),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(4, 6, 4, 0),
                          color: Color(int.parse(note!.noteColor)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 3, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(30, (index) {
                                    if (index.isOdd) {
                                      return Container(
                                        width: 3,
                                        // color: Colors.blueGrey[900],
                                      );
                                    }
                                    return CircleAvatar(
                                        radius: 7,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .background);
                                  }),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 2, 10, 0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SelectableText(
                                          note!.noteTitle,
                                          style: GoogleFonts.signikaNegative(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF263238),
                                          ),
                                        ),
                                        SelectableText(
                                          note!.noteBody,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                color: const Color(0xFF263238),
                                                fontSize: note!.noteFontSize,
                                                fontWeight: FontWeight.w600,
                                                height: 2.4,
                                              ),
                                          textAlign: note!.noteTextAlign ==
                                                  "center"
                                              ? TextAlign.center
                                              : note!.noteTextAlign == "justify"
                                                  ? TextAlign.justify
                                                  : note!.noteTextAlign ==
                                                          "left"
                                                      ? TextAlign.left
                                                      : TextAlign.right,
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
                    ],
                  ),
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
