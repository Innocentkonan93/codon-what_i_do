import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whai_i_do/data/Repositories/repository.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {

  final Repository repository;
  
  NoteCubit(this.repository) : super(NoteInitial());

  void fetchNotes() {}
}
