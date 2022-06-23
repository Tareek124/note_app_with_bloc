import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/sqflite_constants.dart';
import '../model/note_model.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();
  DatabaseProvider._init();
  static Database? _database;
  Future<Database>? get database async {
    if (_database != null) _database;
    _database = await _initDB();
    return _database!;
  }

  Future<Database>? _initDB() async {
    String path = join(await getDatabasesPath(), 'UserDatabase.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database database, int version) async {
    await database.execute('''  
    CREATE TABLE $tableUser (
    $columnID $idType,
    $columnTitle $textType,
    $columnDesc $textType,
    $columnDate $textType
    )
    ''');
  }

  /// CRUD

  // Update
  Future<void> updateUser(NoteModel noteModel) async {
    final db = await instance.database;
    db!.update(
      tableUser,
      noteModel.toMap(),
      where: '$columnID = ?',
      whereArgs: [noteModel.id],
    );
  }

  // Create
  Future<void> createUser(NoteModel noteModel) async {
    final db = await instance.database;
    db!.insert(
      tableUser,
      noteModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("Success");
  }

  // Delete
  Future<void> deleteUser(int? id) async {
    final db = await instance.database;
    db!.delete(
      tableUser,
      where: '$columnID = ?',
      whereArgs: [id],
    );

    print("Deleted");
  }

  // Read One Element
  Future<NoteModel> readOneElement(int? id) async {
    final db = await instance.database;
    final data = await db!.query(
      tableUser,
      where: '$columnID ? =',
      whereArgs: [id],
    );
    return data.isNotEmpty
        ? NoteModel.fromMap(data.first)
        : throw Exception('There is no Data');
  }

  // Read All Elements
  Future<List<NoteModel>> readAllElements() async {
    final db = await instance.database;
    final data = await db!.query(tableUser);
    return data.isNotEmpty
        ? data.map((e) => NoteModel.fromMap(e)).toList()
        : [];
  }
}
