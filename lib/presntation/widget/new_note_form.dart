// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoknot/data/Database/note_database.dart';
import 'package:zoknot/data/Models/Note.dart';
import 'package:zoknot/data/cubit/theme_cubit.dart';

class NewNoteForm extends StatefulWidget {
  final int index;
  NewNoteForm(this.index, {Key? key}) : super(key: key);

  @override
  _NewNoteFormState createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  bool isImportant = false;
  bool isUrgent = false;
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
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    final bool isDark = themeCubit.isDark;
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          height: max(400, 500),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const Text(
                  //   "Nouvelle note",
                  //   style: TextStyle(
                  //     fontSize: 19,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),

                  TextFormField(
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Ajouter un titre";
                      }
                    },
                    controller: titleController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: "Titre",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      isDense: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.05),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Ajouter une description";
                      }
                    },
                    controller: descController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.05),
                    ),
                    maxLines: 5,
                  ),
                  CheckboxListTile(
                    contentPadding: const EdgeInsets.all(1),
                    dense: true,
                    title: const Text(
                      "Urgent",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                    value: isUrgent,
                    onChanged: (newValue) {
                      FocusScope.of(context).unfocus();
                      if (isImportant) {
                        print('null');
                      } else {
                        setState(() {
                          isUrgent = newValue!;
                        });
                      }
                    },
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity
                        .platform, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    contentPadding: const EdgeInsets.all(1),
                    dense: true,
                    title: Text(
                      "Important",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    value: isImportant,
                    onChanged: (newValue) {
                      FocusScope.of(context).unfocus();
                      if (isUrgent) {
                        print('null');
                      } else {
                        setState(() {
                          isImportant = newValue!;
                        });
                      }
                    },
                    activeColor: Colors.cyan,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity
                        .platform, //  <-- leading Checkbox
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await NoteDatabase.instance.create(
                          Note(
                            isImportant: isImportant,
                            isUrgent: isUrgent,
                            number: widget.index + 1,
                            description: descController.text,
                            title: titleController.text,
                            reminderDate: DateTime(0, 0, 0, 0),
                            createdTime: DateTime.now(),
                          ),
                        );
                        Navigator.pop(context, false);
                        refreshNote();
                      }
                    },
                    child: const Text("Ajouter"),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.cyan,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
