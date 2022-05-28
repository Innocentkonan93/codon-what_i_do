import '../models/note_model.dart';
import 'base_note_repository.dart';

class NoteRepository extends BaseNoteRepository {
  @override
  Future<NoteModel> create(NoteModel note) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<int> deleteNote(NoteModel note) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>> readAllNotes() {
    // TODO: implement readAllNotes
    throw UnimplementedError();
  }

  @override
  Future<NoteModel?> readNote(int id) {
    // TODO: implement readNote
    throw UnimplementedError();
  }

  @override
  Future<int> updateNote(NoteModel note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }

}