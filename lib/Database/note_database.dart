// ignore_for_file: prefer_const_declarations

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:whai_i_do/Models/note.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initBD('notes.Db');
    return _database!;
  }

  Future<Database> _initBD(String filePath) async {
    //
    final dbPath = await getDatabasesPath();
    //
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

// CREATE DATABASE
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final numberType = 'INTEGER NOT NULL';

    // await db.execute('''
    // CREATE TABLE $noteTable (
    //   ${NoteFields.id} $idType,
    //   ${NoteFields.isImportant} $boolType,
    //   ${NoteFields.number} $numberType,
    //   ${NoteFields.title} $textType,
    //   ${NoteFields.description} $textType,
    //   ${NoteFields.time} $textType,
    //   )
    // ''');
    await db.execute(
        'CREATE TABLE notes (${NoteFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${NoteFields.isImportant} BOOLEAN NOT NULL, ${NoteFields.number} INTEGER NOT NULL, ${NoteFields.title} TEXT NOT NULL, ${NoteFields.description} TEXT NOT NULL, ${NoteFields.time} TEXT NOT NULL)');
  }

// CREATE NOTE
  Future<Note> create(Note note) async {
    final db = await instance.database;

// insert with own method
// final json = note.toJson();
// final colums = "${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}";
// final values = "${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}";
// final id = await db.rawInsert("INSERT INTO table_name ($colums) VALUES($values) ");

// insert with sqflite method
    final id = await db.insert(noteTable, note.toJson());
    return note.copy(id: id);
  }

// READ ONE NOTE
  Future<Note?> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      noteTable,
      // columns: NoteFields.columns,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      // throw Exception("ID $id not found ");
      return null;
    }
  }

  // READ ALL NOTES

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = "${NoteFields.time} ASC";
    final result = await db.query(
      noteTable,
      orderBy: orderBy,
      
      // limit: 10
    );
    return result.map((json) => Note.fromJson(json)).toList();
  }

  // UPDATE NOTE

  Future<int> updateNote(Note note) async {
    final db = await instance.database;
    return db.update(
      noteTable,
      note.toJson(),
      where: "${NoteFields.id} = ?",
      whereArgs: [note.id],
    );
  }

  // DELETE NOTE
  Future<int> deleteNote(Note note) async {
    final db = await instance.database;
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
