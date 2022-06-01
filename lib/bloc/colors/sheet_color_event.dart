part of 'sheet_color_bloc.dart';

abstract class SheetColorEvent extends Equatable {
  const SheetColorEvent();

  @override
  List<Object> get props => [];
}

class DecideSheetColor extends SheetColorEvent {}

class SetSheetColor extends SheetColorEvent {
  final String colorString;

  const SetSheetColor({required this.colorString});

  @override
  List<Object> get props => [colorString];
}
