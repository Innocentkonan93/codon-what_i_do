// ignore_for_file: unnecessary_this, prefer_const_constructors
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whai_i_do/data/Database/note_database.dart';
import 'package:whai_i_do/data/Models/Note.dart';
import 'package:whai_i_do/data/Services/NotificationService.dart';
import 'package:whai_i_do/data/cubit/note_cubit.dart';
import 'package:whai_i_do/data/cubit/theme_cubit.dart';

import 'package:whai_i_do/presntation/page/note_detail_page.dart';
import 'package:whai_i_do/presntation/widget/new_note_form.dart';
import 'package:whai_i_do/presntation/widget/note_card.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> notes;
  int? index;
  bool isLoading = false;

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    this.notes = await NoteDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshNote();
    super.initState();
  }

  @override
  void dispose() {
    NoteDatabase.instance.closeBD();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NoteCubit>(context).fetchNotes();

    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    bool isDark = themeCubit.isDark;
    return BlocListener<ThemeCubit, ThemeState>(
      listener: (context, state) {
        // if (state is ThemeDark) {
        //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(state.message),
        //     ),
        //   );
        // }
        // if (state is ThemeLight) {
        //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(state.message),
        //     ),
        //   );
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blueGrey[900],
          elevation: 0.0,
          // iconTheme: IconThemeData(
          // color: Colors.white,
          // ),
          title: Text(
            'Zoknot',
            style: GoogleFonts.dancingScript(
              fontSize: 40,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
               
              },
              icon: const Icon(
                Icons.search,
                // color: Colors.white,
              ),
            ),
          ],
        ),
        drawer: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, ThemeState state) {
            return Drawer(
              elevation: 0.0,
              child: Container(
                decoration:
                    BoxDecoration(color: isDark ? Colors.blueGrey[900] : null),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      // decoration: BoxDecoration(
                      //   color: Colors.cyan,
                      // ),
                      child: Center(
                        child: Text(
                          'Zoknot',
                          style: GoogleFonts.dancingScript(
                              fontWeight: FontWeight.w100, fontSize: 60),
                        ),
                      ),
                    ),
                    SwitchListTile.adaptive(
                      activeColor: Colors.cyan,
                      title: Row(
                        children: const [
                          Icon(Icons.dark_mode
                              // color: Colors.white,
                              ),
                          SizedBox(width: 10),
                          Text(
                            'Thème sombre',
                            style: TextStyle(
                                // color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      value: isDark,
                      onChanged: (value) {
                        themeCubit.toggleTheme();
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                        // color: Colors.white,
                      ),
                      title: const Text(
                        'Paramètres',
                        style: TextStyle(
                            // color: Colors.white,
                            ),
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator.adaptive()
              : notes.isEmpty
                  ? const Text("Aucune nouvelle note")
                  : buildNote(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final result = await showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: newNoteDialog(index != null ? index! : 0),
                );
              },
            );

            if (result == false) {
              refreshNote();
            }
          },
          tooltip: "Nouvelle note",
          // backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget newNoteDialog(int index) {
    return NewNoteForm(index);
  }

  Widget buildNote() {
    return StaggeredGridView.countBuilder(
      key: PageStorageKey(index),
      padding: const EdgeInsets.all(8),
      itemCount: notes.length,
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 2.5 : 1.7),
      itemBuilder: (context, index) {
        final note = notes[index];
        this.index = index;
        return GestureDetector(
          onTap: () async {

            await Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => NoteDetailPage(
                  noteId: note.id!,
                ),
              ),
            );
            refreshNote();
          },
          child: NoteCardWidget(
            note: note,
            index: index,
          ),
        );
      },
    );
  }
}
