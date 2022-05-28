import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/note_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesLoading()) {
    on<NotesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
