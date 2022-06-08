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
  static String noteTitle = 'note_title';
  static String noteBody = 'note_body';
  static String noteFilePath = 'note_file_path';
  static String noteColor = 'note_color';
  static String noteNumber = 'note_number';
  static String noteFontSize = 'note_font_size';
  static String noteTextAlign = 'note_text_align';
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
  final double? noteFontSize;
  final String? noteTextAlign;
  final DateTime? noteReminderDate;
  final DateTime noteCreatedDate;

  const NoteModel({
    this.id,
    required this.noteTitle,
    required this.noteBody,
    this.noteFilePath,
    required this.noteColor,
    required this.noteNumber,
    this.noteFontSize,
    this.noteTextAlign,
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
    double? noteFontSize,
    String? noteTextAlign,
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
      noteFontSize: noteFontSize ?? this.noteFontSize,
      noteTextAlign: noteTextAlign ?? this.noteTextAlign,
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
      NoteFields.noteFontSize: noteFontSize,
      NoteFields.noteTextAlign: noteTextAlign,
      NoteFields.noteReminderDate: noteReminderDate!.toIso8601String(),
      NoteFields.noteCreatedDate: noteCreatedDate.toIso8601String(),
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json[NoteFields.id] as int?,
      noteTitle: json[NoteFields.noteTitle] as String,
      noteBody: json[NoteFields.noteBody] as String,
      noteFilePath: json[NoteFields.noteFilePath] as String,
      noteColor: json[NoteFields.noteColor] as String,
      noteNumber: int.parse(json[NoteFields.noteNumber]),
      noteFontSize: double.parse(json[NoteFields.noteFontSize]),
      noteTextAlign: json[NoteFields.noteTextAlign],
      noteReminderDate: DateTime.parse(json[NoteFields.noteReminderDate]),
      noteCreatedDate: DateTime.parse(json[NoteFields.noteCreatedDate]),
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
        noteFontSize,
        noteTextAlign,
        noteReminderDate,
        noteCreatedDate,
      ];
}
