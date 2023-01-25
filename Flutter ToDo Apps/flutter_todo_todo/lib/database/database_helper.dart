import 'package:flutter_todo_todo/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'tasks';

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + "tasks.db";
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print('creat new one');
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING, note TEXT, date STRING,"
            "startTime STRING, endTime STRING,"
            "remind INTEGER, repeat STRING,"
            "color INTEGER,"
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

// this function for insert data in our database
  static Future<int> insert(Task? task) async {
    print('Database is called');
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

// this functio for get all data from query wise
  static Future<List<Map<String, dynamic>>> query() async {
    print('Query functions called');
    return await _db!.query(_tableName);
  }

  //this function for delete data from our database

  static delete(Task task) async {
    return await _db!.delete(
      _tableName,
      where: 'id=?',
      whereArgs: [task.id],
    );
  }

  // this method for updating task

  static update(int id) async {
    return await _db!.rawUpdate('''
           UPDATE tasks
           SET isCompleted = ?
           WHERE id=?
            ''', [1, id]);
  }
}
