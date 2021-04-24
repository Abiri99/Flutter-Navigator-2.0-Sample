import 'package:flutter_navigator2_sample/core/model/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class TodoDatabaseHelper {
  Future<Database> database;

  Future<void> setup() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT)');
      },
      version: 1,
    );
  }

  Future<void> insertTodo(Todo todo) async {
    final Database db = await database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> todos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> todos = await db.query('todos');
    return List.generate(todos.length, (i) {
      return Todo(
        id: todos[i]['id'],
        title: todos[i]['title'],
        description: todos[i]['description'],
      );
    });
  }

  Future<void> updateTodo(Todo todo) async {
    final Database db = await database;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(int id) async {
    final Database db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
