// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:whai_i_do/Database/note_database.dart';
import 'package:whai_i_do/Models/note.dart';
import 'package:whai_i_do/page/note_detail_page.dart';
import 'package:whai_i_do/widget/new_note_form.dart';
import 'package:whai_i_do/widget/note_card.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Note',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 0.0,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
                child: Text(
                  'Noteur',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 60
                  )
                  
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.light_mode,
                  color: Colors.white,
                ),
                title: const Text(
                  'Thème sombre',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: const Text(
                  'Paramètres',
                  style: TextStyle(
                    color: Colors.white,
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
        backgroundColor: Colors.white,
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
