part of 'sheet_style_bloc.dart';

abstract class SheetStyleState extends Equatable {
  const SheetStyleState();

  @override
  List<Object> get props => [];
}

class StyleLoaded extends SheetStyleState {
  final double fontSize;
  final String texAlign;

  const StyleLoaded({ required this.fontSize, required this.texAlign});
}
