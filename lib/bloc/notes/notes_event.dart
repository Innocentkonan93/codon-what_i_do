part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

// ? Load
class LoadNotes extends NotesEvent {

}

//? Update
class UpdateNotes extends NotesEvent {
  final List<NoteModel> notes;

  const UpdateNotes({required this.notes});

  @override
  List<Object> get props => [notes];
}

//? Load single Note
class LoadSingleNote extends NotesEvent {
  final int noteId;

  const LoadSingleNote({required this.noteId});

  @override
  List<Object> get props => [noteId];
}

//? Add
class AddNote extends NotesEvent {
  final NoteModel note;

  const AddNote({required this.note});

  @override
  List<Object> get props => [note];
}

//? Edit
class EditNote extends NotesEvent {
  final List<NoteModel> note;

  const EditNote({required this.note});

  @override
  List<Object> get props => [note];
}

//? Delete
class DeleteNote extends NotesEvent {
  final NoteModel note;

  const DeleteNote({required this.note});

  @override
  List<Object> get props => [note];
}
