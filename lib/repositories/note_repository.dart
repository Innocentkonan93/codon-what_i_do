import 'package:zoknot/database/database.dart';

import '../models/note_model.dart';
import 'base_note_repository.dart';

class NoteRepository extends BaseNoteRepository {
  NewNoteDatabase noteDatabase = NewNoteDatabase.instance;
  @override
  Future<NoteModel> create(NoteModel note) {
    return noteDatabase.create(note);
  }

  @override
  Future<int> deleteNote(NoteModel note) {
    return noteDatabase.deleteNote(note);
  }

  @override
  Future<List<NoteModel>> readAllNotes() {
    return noteDatabase.readAllNotes();
  }

  @override
  Future<NoteModel?> readNote(int id) {
    return noteDatabase.readNote(id);
  }

  @override
  Future<int> updateNote(NoteModel note) {
    return noteDatabase.updateNote(note);
  }
}
