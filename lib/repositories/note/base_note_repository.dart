import '../../models/note_model.dart';

abstract class BaseNoteRepository {
  Future<NoteModel> create(NoteModel note);
  Future<NoteModel?> readNote(int id);
  Future<List<NoteModel>> readAllNotes();
  Future<int> updateNote(NoteModel note);
  Future<int> deleteNote(NoteModel note);
}
