import 'package:flutter/material.dart';
import 'package:whai_i_do/Database/note_database.dart';
import 'package:whai_i_do/Models/note.dart';

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blueGrey[900],
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await NoteDatabase.instance.updateNote(
                  Note(
                    title: titleController.text,
                    description: descriptionController.text,
                    isImportant: widget.note.isImportant,
                    number: widget.note.number,
                    id: widget.note.id,
                    createdTime: widget.note.createdTime
                  ),
                ).then((value) {
                  Navigator.pop(context, true);
                });
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                      // border: InputBorder.none
                      hintText: "Titre",
                      ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: descriptionController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    // border: InputBorder.none
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
