import 'package:equatable/equatable.dart';

String noteTable = 'notes';

class NoteFields {
  static final List<String> noteColumns = [
    id,
    noteTitle,
    noteBody,
    noteFilePath,
    noteColor,
    noteNumber,
    noteReminderDate,
    noteCreatedDate
  ];
  static String id = '_id';
  static String noteTitle = 'noet_title';
  static String noteBody = 'note_body';
  static String noteFilePath = 'note_file_path';
  static String noteColor = 'note_color';
  static String noteNumber = 'note_number';
  static String noteReminderDate = 'note_reminder_date';
  static String noteCreatedDate = 'note_created_date';
}

class NoteModel extends Equatable {
  final int? id;
  final String noteTitle;
  final String noteBody;
  final String? noteFilePath;
  final String noteColor;
  final int noteNumber;
  final DateTime? noteReminderDate;
  final DateTime noteCreatedDate;

  const NoteModel({
    this.id,
    required this.noteTitle,
    required this.noteBody,
    this.noteFilePath,
    required this.noteColor,
    required this.noteNumber,
    this.noteReminderDate,
    required this.noteCreatedDate,
  });

  NoteModel copyWith({
    int? id,
    String? noteTitle,
    String? noteBody,
    String? noteFilePath,
    String? noteColor,
    int? noteNumber,
    DateTime? noteReminderDate,
    DateTime? noteCreatedDate,
  }) {
    return NoteModel(
      id: id ?? this.id,
      noteTitle: noteTitle ?? this.noteTitle,
      noteBody: noteBody ?? this.noteBody,
      noteFilePath: noteFilePath ?? this.noteFilePath,
      noteColor: noteColor ?? this.noteColor,
      noteNumber: noteNumber ?? this.noteNumber,
      noteReminderDate: noteReminderDate ?? this.noteReminderDate,
      noteCreatedDate: noteCreatedDate ?? this.noteCreatedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NoteFields.id: id,
      NoteFields.noteTitle: noteTitle,
      NoteFields.noteBody: noteBody,
      NoteFields.noteFilePath: noteFilePath,
      NoteFields.noteColor: noteColor,
      NoteFields.noteNumber: noteNumber,
      NoteFields.noteReminderDate: noteReminderDate!.toIso8601String(),
      NoteFields.noteCreatedDate: noteCreatedDate.toIso8601String(),
    };
  }

  factory NoteModel.fromJson(Map<String, Object?> json) {
    return NoteModel(
      id: json[NoteFields.id] as int?,
      noteTitle: json[NoteFields.noteTitle] as String,
      noteBody: json[NoteFields.noteBody] as String,
      noteFilePath: json[NoteFields.noteFilePath] as String,
      noteColor: json[NoteFields.noteColor] as String,
      noteNumber: json[NoteFields.noteNumber] as int,
      noteReminderDate:
          DateTime.parse(json[NoteFields.noteReminderDate] as String),
      noteCreatedDate:
          DateTime.parse(json[NoteFields.noteCreatedDate] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        noteTitle,
        noteBody,
        noteFilePath,
        noteColor,
        noteNumber,
        noteReminderDate,
        noteCreatedDate,
      ];
}
