part of 'change_theme_bloc.dart';

abstract class ChangeThemeEvent extends Equatable {
  const ChangeThemeEvent();

  @override
  List<Object> get props => [];
}

class DecideTheme extends ChangeThemeEvent {}

class DarkTheme extends ChangeThemeEvent {
  final ThemeData darkTheme;

  const DarkTheme({required this.darkTheme});
  @override
  List<Object> get props => [darkTheme];
}

class LightTheme extends ChangeThemeEvent {
  final ThemeData lighTheme;

  const LightTheme({required this.lighTheme});
  @override
  List<Object> get props => [lighTheme];
}
