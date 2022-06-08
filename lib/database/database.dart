// ignore_for_file: prefer_const_declarations

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';

class NewNoteDatabase {
  static final NewNoteDatabase instance = NewNoteDatabase._init();

  static Database? _database;

  NewNoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initBD('sprzknts.Db');
    return _database!;
  }

  Future<Database> _initBD(String filePath) async {
    //
    final dbPath = await getDatabasesPath();
    //
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

// CREATE DATABASE
  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE notes (${NoteFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${NoteFields.noteTitle} TEXT NOT NULL, ${NoteFields.noteBody} TEXT NOT NULL, ${NoteFields.noteFilePath} TEXT NULL, ${NoteFields.noteColor} TEXT NOT NULL, ${NoteFields.noteNumber} TEXT NOT NULL, ${NoteFields.noteFontSize} TEXT NULL, ${NoteFields.noteTextAlign} TEXT NULL, ${NoteFields.noteReminderDate} TEXT NULL, ${NoteFields.noteCreatedDate} TEXT NOT NULL)');
  }

// CREATE NOTE
  Future<NoteModel> create(NoteModel note) async {
    final db = await instance.database;

// insert with sqflite method
    final id = await db.insert(noteTable, note.toJson());
    print("note created");
    return note.copyWith(id: id);
  }

// READ ONE NOTE
  Future<NoteModel?> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      noteTable,
      // columns: NoteFields.columns,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      print("note read");
      return NoteModel.fromJson(maps.first);
    } else {
      // throw Exception("ID $id not found ");
      return null;
    }
  }

  // READ ALL NOTES

  Future<List<NoteModel>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = "${NoteFields.noteCreatedDate} ASC";
    final result = await db.query(
      noteTable,
      orderBy: orderBy,

      // limit: 10
    );
    print("read all notes");
    return result.map((json) => NoteModel.fromJson(json)).toList();
  }

  // UPDATE NOTE

  Future<int> updateNote(NoteModel note) async {
    final db = await instance.database;
    print("note updated");
    return db.update(
      noteTable,
      note.toJson(),
      where: "${NoteFields.id} = ?",
      whereArgs: [note.id],
    );
  }

  // DELETE NOTE
  Future<int> deleteNote(NoteModel note) async {
    final db = await instance.database;
    print("note deleted");
    return db.delete(
      noteTable,
      where: "${NoteFields.id} = ?",
      whereArgs: [note.id],
    );
  }

  Future closeBD() async {
    final db = await instance.database;
    _database = null;
    return db.close();
  }
}
