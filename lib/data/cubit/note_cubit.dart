import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoknot/data/Repositories/repository.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {

  final Repository repository;

  NoteCubit(this.repository) : super(NoteInitial());

  void fetchNotes() {
    repository.fetchNotesData();
  }
}
