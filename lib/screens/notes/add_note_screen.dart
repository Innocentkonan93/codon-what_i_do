// ignore_for_file: avoid_print, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoknot/bloc/colors/sheet_color_bloc.dart';
import 'package:zoknot/models/note_model.dart';
import 'package:zoknot/widgets/widgets.dart';

import '../../bloc/notes/notes_bloc.dart';
import '../../bloc/style/sheet_style_bloc.dart';

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
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _bodycontroller = TextEditingController();
  int? index;
  String? sheetColor;

  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetStyleBloc, SheetStyleState>(
      builder: (context, styleState) {
        double noteFontSize = (styleState as StyleLoaded).fontSize;
        String noteTextAlign = (styleState as StyleLoaded).texAlign;
        return BlocBuilder<SheetColorBloc, SheetColorState>(
          builder: (context, colorstate) {
            String noteColor = (colorstate as SheetColorLoaded).colorString;
            return BlocConsumer<NotesBloc, NotesState>(
              listener: (context, notestate) {
                if (notestate is NotesLoaded) {
                  Navigator.pop(context);
                }
              },
              builder: (context, notestate) {
                NoteModel note = NoteModel(
                  noteTitle: _titlecontroller.text,
                  noteBody: _bodycontroller.text,
                  noteFilePath: "",
                  noteColor: noteColor,
                  noteNumber: index != null ? index! : 0,
                  noteFontSize: noteFontSize,
                  noteTextAlign: noteTextAlign,
                  noteReminderDate: DateTime.now(),
                  noteCreatedDate: DateTime.now(),
                );
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/x.svg",
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (_bodycontroller.text.isNotEmpty) {
                            context.read<NotesBloc>().add(
                                  AddNote(note: note),
                                );
                          } else {
                            const snackBar = SnackBar(
                              backgroundColor: Colors.orange,
                              content: Text(
                                'Veuillez ??crire quelque chose...',
                                // style: TextStyle(color: Colors.red,),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
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
                          NewNoteSheet(
                            titlecontroller: _titlecontroller,
                            bodycontroller: _bodycontroller,
                            textStyle: const TextStyle(),
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
                  bottomSheet: SafeArea(
                    child: CustomBottomSheet(
                      focusNode: focusNode,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
