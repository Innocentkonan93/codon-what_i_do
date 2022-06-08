import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sheet_style_event.dart';
part 'sheet_style_state.dart';

class SheetStyleBloc extends Bloc<StyleEvent, SheetStyleState> {
  SheetStyleBloc() : super(const StyleLoaded(fontSize: 16, texAlign: "left")) {
    on<DecideSheetStyle>(_onDecideSheetStyle);
    on<SetSheetStyle>(_onSetSheetStyle);
  }

  void _onDecideSheetStyle(
      DecideSheetStyle event, Emitter<SheetStyleState> emit) {
    add(const SetSheetStyle(fontSize: 14, textAlign: 'left'));
  }

  void _onSetSheetStyle(SetSheetStyle event, Emitter<SheetStyleState> emit) {
    emit(StyleLoaded(fontSize: event.fontSize, texAlign: event.textAlign));
  }
}
