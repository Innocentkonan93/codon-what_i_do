// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoknot/App/AppRoutes.dart';
import 'package:zoknot/data/cubit/theme_cubit.dart';
import 'package:zoknot/main.dart';

class CustomBlocProvider extends StatelessWidget {
  const CustomBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child:  MyApp(appRouter: AppRouter(),),
    );
  }
}
