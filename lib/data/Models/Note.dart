// ignore: file_names
// ignore_for_file: prefer_const_declarations

final String noteTable = 'notes';

class NoteFields {
  static final List<String> columns = [
    id,
    isImportant,
    isUrgent,
    number,
    title,
    description,
    reminderDate,
    time
  ];
  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String isUrgent = 'isUrgent';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String reminderDate = 'reminderDate';
  static final String time = 'time';
}

class Note {
  final int? id;
  final bool isImportant;
  final bool isUrgent;
  final int number;
  final String title;
  final String description;
  final DateTime? reminderDate;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.isUrgent,
    required this.number,
    required this.title,
    required this.description,
    required this.reminderDate,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isImportant,
    bool? isUrgent,
    int? number,
    String? title,
    String? description,
    DateTime? reminderDate,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        isUrgent: isUrgent ?? this.isUrgent,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        reminderDate: reminderDate ?? this.reminderDate,
        createdTime: createdTime ?? this.createdTime,
      );

      //
  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        isUrgent : json[NoteFields.isUrgent] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        reminderDate : DateTime.parse(json[NoteFields.reminderDate] as String),
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

      //
  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.isUrgent: isUrgent ? 1 : 0,
        NoteFields.number: number,
        NoteFields.description: description,
        NoteFields.reminderDate: reminderDate!.toIso8601String(),
        NoteFields.time: createdTime.toIso8601String()
      };
}
