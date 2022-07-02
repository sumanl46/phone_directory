import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/todo.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE lists(id INTEGER PRIMARY KEY AUTOINCREMENT, phoneNumber TEXT NOT NULL, username TEXT NOT NULL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await database();

    await _db.insert('lists', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Todo>> getTodos() async {
    Database db = await database();

    final List<Map<String, dynamic>> maps =
        await db.query('lists', orderBy: "id DESC");

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        phoneNumber: maps[i]['phoneNumber'],
        username: maps[i]['username'],
      );
    });
  }

  Future<void> deleteTodo(int id) async {
    Database db = await database();

    // Remove the Dog from the database.
    await db.delete(
      'lists',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
