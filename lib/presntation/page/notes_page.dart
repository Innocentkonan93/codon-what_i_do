// ignore_for_file: unnecessary_this, prefer_const_constructors
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:zoknot/data/Database/note_database.dart';
import 'package:zoknot/data/Models/Note.dart';
import 'package:zoknot/data/cubit/note_cubit.dart';
import 'package:zoknot/data/cubit/theme_cubit.dart';

import 'package:zoknot/presntation/page/note_detail_page.dart';
import 'package:zoknot/presntation/widget/new_note_form.dart';
import 'package:zoknot/presntation/widget/note_card.dart';

import '../widget/zoknot.dart';

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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Zoknot();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.search,
                // color: Colors.white,
              ),
            ),
          ],
        ),
        drawer: CustomDrawer(isDark: isDark, themeCubit: themeCubit),
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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.isDark,
    required this.themeCubit,
  }) : super(key: key);

  final bool isDark;
  final ThemeCubit themeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
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
                    Icons.logout,
                    // color: Colors.white,
                  ),
                  title: const Text(
                    'Exit',
                    style: TextStyle(
                        // color: Colors.white,
                        ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
