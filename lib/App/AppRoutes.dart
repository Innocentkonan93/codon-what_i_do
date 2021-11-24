// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whai_i_do/data/Repositories/repository.dart';
import 'package:whai_i_do/data/cubit/note_cubit.dart';
import 'package:whai_i_do/data/cubit/theme_cubit.dart';
import 'package:whai_i_do/presntation/page/edit_note_page.dart';
import 'package:whai_i_do/presntation/page/note_detail_page.dart';
import 'package:whai_i_do/presntation/page/notes_page.dart';

class AppRouter {
  late ThemeCubit themeCubit;

  //!nouveau
  late Repository repository;

  AppRouter() {
    themeCubit = ThemeCubit();
  //!nouveau

    repository = Repository();
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(
          //!nouveau
          builder: (_) => BlocProvider(
            create: (context) => NoteCubit(repository: repository),
            child: NotePage(),
          ),
        );
    }
  }
}
