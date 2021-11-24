// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whai_i_do/App/AppRoutes.dart';
import 'package:whai_i_do/data/cubit/theme_cubit.dart';
import 'package:whai_i_do/main.dart';

class CustomBlocProvider extends StatelessWidget {
  const CustomBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        )
      ],
      child:  MyApp(appRouter: AppRouter(),),
    );
  }
}
