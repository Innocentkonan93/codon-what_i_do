part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesLoading extends NotesState {}

class NoteAdded extends NotesState {}

class NoteUpdated extends NotesState {}

class NoteDeleted extends NotesState {}

class NotesLoaded extends NotesState {
  final List<NoteModel> notes;

  const NotesLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}
