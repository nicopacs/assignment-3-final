// ignore_for_file: depend_on_referenced_packages

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import '../models/model.dart';

class DatabaseHelper{
  // ignore: prefer_typing_uninitialized_variables
  static Database? _db;

  Future<Database?> get db async => _db ??= await initDatabase();

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'text.db');

    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;

  }
  /// DATABASE
  _createDatabase(Database db, int version) async{
    await db.execute("CREATE TABLE dbTodo(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "author TEXT NOT NULL,"
        "title TEXT NOT NULL, "
        "description TEXT NOT NULL)"
    );
  }
  /// INSERT
  Future<TextModel> insert(TextModel textModel) async{
    var dbClient = await db;
    await dbClient?.insert('dbTodo', textModel.toMap());
    return textModel;
  }
  /// GET DATA LIST
  Future<List<TextModel>> getDataList() async{
    await db;
    final List<Map<String, Object?>> queryResult = await _db!.rawQuery(
        'SELECT * FROM dbTodo');
    return queryResult.map((e) => TextModel.fromMap(e)).toList();
  }
  /// DELETE
  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient!.delete('dbTodo', where: 'id = ?', whereArgs: [id]);
  }
  /// UPDATE
  Future <int> update(TextModel textModel) async{
    var dbClient = await db;
    return await dbClient!.update('dbTodo',
        textModel.toMap(), where: 'id = ?', whereArgs: [textModel.id]);
  }
}