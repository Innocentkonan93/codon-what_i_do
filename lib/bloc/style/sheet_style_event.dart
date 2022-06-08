part of 'sheet_style_bloc.dart';

abstract class StyleEvent extends Equatable {
  const StyleEvent();

  @override
  List<Object> get props => [];
}

class DecideSheetStyle extends StyleEvent {}

class SetSheetStyle extends StyleEvent {
  final double fontSize;
  final String textAlign;

  const SetSheetStyle({required this.fontSize, required this.textAlign});

  @override
  List<Object> get props => [
        fontSize,
        textAlign,
      ];
}
