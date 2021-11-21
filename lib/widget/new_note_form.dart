// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whai_i_do/Database/note_database.dart';
import 'package:whai_i_do/Models/note.dart';

class NewNoteForm extends StatefulWidget {
  final int index;
  NewNoteForm(this.index, {Key? key}) : super(key: key);

  @override
  _NewNoteFormState createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  bool checkedValue = false;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late List<Note> notes;
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
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        height: max(400, 500),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Nouvelle note",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Ajouter un titre";
                    }
                  },
                  controller: titleController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "Titre",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.05),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Ajouter une description";
                    }
                  },
                  controller: descController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.05),
                  ),
                  maxLines: 5,
                ),
                CheckboxListTile(
                  title: Text("Marqué important"),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue!;
                    });
                  },
                  activeColor: Colors.cyan,
                  checkColor: Colors.white,
                  controlAffinity:
                      ListTileControlAffinity.platform, //  <-- leading Checkbox
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await NoteDatabase.instance.create(
                        Note(
                          isImportant: checkedValue,
                          number: widget.index + 1,
                          description: descController.text,
                          title: titleController.text,
                          createdTime: DateTime.now(),
                        ),
                      );
                      Navigator.pop(context, false);
                      refreshNote();
                    }
                  },
                  child: Text("Ajouter"),
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
