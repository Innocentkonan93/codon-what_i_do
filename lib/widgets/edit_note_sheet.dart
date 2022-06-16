import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoknot/models/note_model.dart';

import '../bloc/colors/sheet_color_bloc.dart';

class EditNoteSheet extends StatelessWidget {
  const EditNoteSheet({
    required this.note,
    required this.focusNode,
    required this.onTitleChanged,
    required this.onBodyChanged,
    Key? key,
  }) : super(key: key);
  final NoteModel note;
  final FocusNode focusNode;
  final Function(String)? onTitleChanged;
  final Function(String)? onBodyChanged;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    // final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return BlocBuilder<SheetColorBloc, SheetColorState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
          height: size / 2,
          // height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            color: Color(int.parse(note.noteColor)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                color: Colors.black.withOpacity(0.16),
                blurRadius: 6,
              )
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(30, (index) {
                    if (index.isOdd) {
                      return Container(
                        width: 3,
                        // color: Colors.blueGrey[900],
                      );
                    }
                    return CircleAvatar(
                      radius: 7,
                      backgroundColor: Theme.of(context).colorScheme.background,
                    );
                  }),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: note.noteTitle,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ajouter un itre',
                          ),
                          cursorColor: const Color(0xFF263238),
                          style: GoogleFonts.signikaNegative(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          onChanged: onTitleChanged,
                        ),
                        TextFormField(
                          initialValue: note.noteBody,
                          focusNode: focusNode,
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Votre text ici...',
                          ),
                          cursorColor: const Color(0xFF263238),
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: const Color(0xFF263238),
                                    fontSize: note.noteFontSize,
                                    fontWeight: FontWeight.w600,
                                    height: 2.4,
                                  ),
                          textAlign: note.noteTextAlign == "center"
                              ? TextAlign.center
                              : note.noteTextAlign == "justify"
                                  ? TextAlign.justify
                                  : note.noteTextAlign == "left"
                                      ? TextAlign.left
                                      : TextAlign.right,
                          onChanged: onBodyChanged,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
