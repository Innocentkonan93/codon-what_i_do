part of 'sheet_color_bloc.dart';

abstract class SheetColorState extends Equatable {
  const SheetColorState();

  @override
  List<Object> get props => [];
}



class SheetColorLoaded extends SheetColorState {
  final String colorString;

  const SheetColorLoaded({required this.colorString});

  @override
  List<Object> get props => [colorString];
}
