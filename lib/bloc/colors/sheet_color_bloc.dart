import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sheet_color_event.dart';
part 'sheet_color_state.dart';

class SheetColorBloc extends Bloc<SheetColorEvent, SheetColorState> {
  SheetColorBloc() : super(const SheetColorLoaded(colorString: '0XFF1ba9c3')) {
    on<DecideSheetColor>(_onDecideSheetColor);
    on<SetSheetColor>(_onSetSheetColor);
  }

  void _onDecideSheetColor(
      DecideSheetColor event, Emitter<SheetColorState> emit) {
    add(const SetSheetColor(colorString: "0XFF1ba9c3"));
  }

  void _onSetSheetColor(SetSheetColor event, Emitter<SheetColorState> emit) {
    emit(SheetColorLoaded(colorString: event.colorString));
  }
}
