part of 'change_theme_bloc.dart';

abstract class ChangeThemeState extends Equatable {
  const ChangeThemeState();

  @override
  List<Object> get props => [];
}

class ChangeThemeInitial extends ChangeThemeState {}

class LoadTheme extends ChangeThemeState {
  final ThemeData themeData;

  const LoadTheme({required this.themeData});

  @override
  List<Object> get props => [themeData];
}
