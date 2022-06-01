import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zoknot/repositories/note/note_repository.dart';

import '../../models/note_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  StreamSubscription? _noteSusbscription;
  final NoteRepository _noteRepository;
  NotesBloc({required NoteRepository noteRepository})
      : _noteRepository = noteRepository,
        super(NotesLoading()) {
    on<LoadNotes>(_onLoadNotes);
    on<UpdateNotes>(_onUpdateNotes);
    on<LoadSingleNote>(_onLoadSingleNote);
    on<AddNote>(_onAddNote);
    on<EditNote>(_onEditNote);
    on<DeleteNote>(_onDeleteNote);
  }

  void _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    try {
      if (kDebugMode) {
      print('notes loading');
      }
      emit(NotesLoading());
      _noteSusbscription?.cancel();
      _noteSusbscription =
          _noteRepository.readAllNotes().asStream().listen((notes) {
        add(UpdateNotes(notes: notes));
      });
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  void _onUpdateNotes(UpdateNotes event, Emitter<NotesState> emit) async {
    try {
      if (kDebugMode) {
        print('notes loaded');
      }
      emit(NotesLoaded(notes: event.notes));
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  void _onLoadSingleNote(LoadSingleNote event, Emitter<NotesState> emit) async {
    try {
      if (kDebugMode) {
        print('note loaded');
      }
      _noteSusbscription?.cancel();

      _noteSusbscription =
          _noteRepository.readNote(event.noteId).asStream().listen((note) {
        add(LoadNotes());
      });
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  void _onAddNote(AddNote event, Emitter<NotesState> emit) {
    try {
      _noteSusbscription?.cancel();

      _noteSusbscription =
          _noteRepository.create(event.note).asStream().listen((note) {
        if (note.id != null) {
          add(LoadNotes());
        } else {}
      });
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  void _onEditNote(EditNote event, Emitter<NotesState> emit) {
    try {
      _noteSusbscription?.cancel();

      _noteSusbscription =
          _noteRepository.updateNote(event.note).asStream().listen((noteid) {
        add(LoadNotes());
      });
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }

  void _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) {
    try {
      _noteSusbscription?.cancel();

      _noteSusbscription =
          _noteRepository.deleteNote(event.note).asStream().listen((noteid) {
        add(LoadNotes());
      });
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }
}
