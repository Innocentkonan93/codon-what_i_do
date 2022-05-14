import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  bool _isDark = true;
  bool get isDark => _isDark;

  void toggleTheme(){
    _isDark = ! _isDark;
    print(_isDark);
    emit(ThemeChanged());
    if(_isDark){
      emit(ThemeDark(message: "Theme sombre activé"));
    }else{
      emit(ThemeLight(message: "Theme clair activé"));
    }
  }
}
