import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/colors/sheet_color_bloc.dart';
import '../../bloc/notes/notes_bloc.dart';
import '../../models/note_model.dart';
import '../../widgets/edit_note_sheet.dart';
import '../../widgets/widgets.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({required this.note, Key? key}) : super(key: key);

  final NoteModel note;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NoteModel note = widget.note;
    return BlocConsumer<NotesBloc, NotesState>(
      listener: (context, notestate) {
        if (notestate is NotesLoaded) {
          Navigator.pop(context);
        }
      },
      builder: (context, notestate) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            actions: [
              TextButton(
                onPressed: () {
                  context.read<NotesBloc>().add(
                        EditNote(note: note),
                      );
                },
                child: SvgPicture.asset(
                  "assets/icons/check.svg",
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  EditNoteSheet(
                    note: note,
                    focusNode: focusNode,
                    onTitleChanged: (title) {
                      note = note.copyWith(noteTitle: title);
                      print(title);
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
            note: note,
            focusNode: focusNode,
          ),
        );
      },
    );
  }
}
