import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoknot/data/cubit/theme_cubit.dart';
import '../../data/Database/note_database.dart';
import '../../data/Models/Note.dart';

class EditNotePage extends StatefulWidget {
  final Note note;
  const EditNotePage(this.note, {Key? key}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    titleController = TextEditingController(text: widget.note.title);
    descriptionController =
        TextEditingController(text: widget.note.description);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    bool isDark = themeCubit.isDark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await NoteDatabase.instance
                    .updateNote(
                  Note(
                      id: widget.note.id,
                      title: titleController.text,
                      isImportant: widget.note.isImportant,
                      isUrgent: widget.note.isUrgent,
                      number: widget.note.number,
                      description: descriptionController.text,
                      reminderDate: widget.note.reminderDate,
                      createdTime: widget.note.createdTime),
                )
                    .then((value) {
                  Navigator.pop(context, true);
                });
              },
              child: Text(
                'Enregistrer',
                style: TextStyle(
                  color: isDark ? Colors.green : Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle:
                        TextStyle(color: isDark ? Colors.white : Colors.black),
                    hintText: "Titre",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  autofocus: true,
                  controller: descriptionController,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description",
                  ),
                  maxLines: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
