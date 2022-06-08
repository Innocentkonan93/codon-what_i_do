// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoknot/bloc/colors/sheet_color_bloc.dart';
import 'package:zoknot/bloc/notes/notes_bloc.dart';
import 'package:zoknot/bloc/style/sheet_style_bloc.dart';
import 'package:zoknot/bloc/theme/change_theme_bloc.dart';
import 'package:zoknot/main.dart';

import '../repositories/note/note_repository.dart';

class CustomBlocProvider extends StatelessWidget {
  const CustomBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesBloc(noteRepository: NoteRepository())
            ..add(
              LoadNotes(),
            ),
        ),
        BlocProvider(
          create: (context) => ChangeThemeBloc()..add(DecideTheme()),
        ),
        BlocProvider(
          create: (context) => SheetColorBloc()..add(DecideSheetColor()),
        ),
        BlocProvider(
          create: (context) => SheetStyleBloc(),
        ),
      ],
      child: const MyApp(),
    );
  }
}
