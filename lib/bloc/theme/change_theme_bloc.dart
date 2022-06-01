import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoknot/configs/theme.dart';

part 'change_theme_event.dart';
part 'change_theme_state.dart';

class ChangeThemeBloc extends Bloc<ChangeThemeEvent, ChangeThemeState> {
  ChangeThemeBloc() : super(ChangeThemeInitial()) {
    on<DecideTheme>(_onDecideTheme);
    on<LightTheme>(_onLightTheme);
    on<DarkTheme>(_onDarkTheme);
  }

  void _onDecideTheme(DecideTheme event, Emitter<ChangeThemeState> emit) async {
    final int optionValue = await getOption();
    if (optionValue == 0) {
      // yield ChangeThemeState.lightTheme();
      add(LightTheme(lighTheme: lightTheme));
    } else if (optionValue == 1) {
      // yield ChangeThemeState.darkTheme();
      add(DarkTheme(darkTheme: darkTheme));
    }
  }

  void _onLightTheme(LightTheme event, Emitter<ChangeThemeState> emit) {
    emit(LoadTheme(themeData: event.lighTheme));
    try {
      saveOptionValue(0);
    } catch (_) {
      print(_);
    }
  }

  void _onDarkTheme(DarkTheme event, Emitter<ChangeThemeState> emit) {
    emit(LoadTheme(themeData: event.darkTheme));
    try {
      saveOptionValue(1);
    } catch (_) {
      print(_);
    }
  }

  Future<void> saveOptionValue(int optionValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('theme_option', optionValue);
    print('Saving option value as $optionValue successfully');
  }

  Future<int> getOption() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int option = preferences.getInt('theme_option') ?? 0;
    return option;
  }
}
