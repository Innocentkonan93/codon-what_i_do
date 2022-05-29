import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoknot/models/note_model.dart';
import 'package:zoknot/widgets/widgets.dart';

import '../../bloc/notes/notes_bloc.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);
  static const routeName = '/add-note-screen';

  static Route route() {
    return MaterialPageRoute(builder: (context) {
      return const AddNoteScreen();
    });
  }

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  int? index;
  @override
  Widget build(BuildContext context) {
    Color sheetColor = Theme.of(context).colorScheme.primary;
    NoteModel note = NoteModel(
      noteTitle: "",
      noteBody: "",
      noteFilePath: "",
      noteColor: "0xFFf39591",
      noteNumber: index != null ? index! : 0,
      noteReminderDate: DateTime.now(),
      noteCreatedDate: DateTime.now(),
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocConsumer<NotesBloc, NotesState>(
              listener: (context, state) {
                if (state is NotesLoaded) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return TextButton(
                  onPressed: () {
                    context.read<NotesBloc>().add(
                          AddNote(note: note),
                        );
                  },
                  child: SvgPicture.asset(
                    "assets/icons/check.svg",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
            )
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NewNoteSheet(
                  sheetColor: Color(int.parse(note.noteColor)),
                  textStyle: TextStyle(),
                  onTitleChanged: (title) {
                    note = note.copyWith(noteTitle: title);
                  },
                  onBodyChanged: (body) {
                    note = note.copyWith(noteBody: body);
                  },
                )
              ],
            ),
          ),
        ),
        bottomSheet: CustomBottomSheet(
          sheetColor: sheetColor,
        ),
      ),
    );
  }
}
