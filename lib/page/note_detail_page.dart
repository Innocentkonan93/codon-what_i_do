import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:whai_i_do/Database/note_database.dart';
import 'package:whai_i_do/Models/note.dart';
import 'package:whai_i_do/page/edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  NoteDetailPage({required this.noteId});

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  FocusNode focusNode = FocusNode();
  Note? note;
  bool isLoading = false;

  @override
  void initState() {
    refreshNote();

    super.initState();
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
    return isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Scaffold(
            backgroundColor: Colors.blueGrey[900],
            appBar: AppBar(
              title: const Text(""),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.blueGrey[900],
              elevation: 0.0,
              actions: [
                IconButton(
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
                IconButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: SizedBox(
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
                                          style:
                                              TextStyle(color: Colors.red[900]),
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
              ],
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: note?.isImportant != true
                        ? Colors.yellow[700]
                        : Colors.cyan,
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
                              color: Colors.blueGrey[900],
                            );
                          }
                          return CircleAvatar(
                            radius: 7,
                            backgroundColor: Colors.blueGrey[900],
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Créée le " +
                                              DateFormat("d.M.yyyy ")
                                                  .format(note!.createdTime)
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
                                        Text(note!.title,
                                            // style: const TextStyle(
                                            //   fontSize: 22,
                                            //   fontWeight: FontWeight.bold,
                                            //   // color: Colors.white,
                                            // ),
                                            style: GoogleFonts.quicksand(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        note!.description,
                                        // style: const TextStyle(
                                        //   // color: Colors.white,
                                        //   fontSize: 18
                                        // ),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
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
          );
  }
}
