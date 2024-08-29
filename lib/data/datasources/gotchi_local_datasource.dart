import 'package:sqflite/sqflite.dart';

class RealGotchiLocalDatasource {
  static final RealGotchiLocalDatasource _instance =
      RealGotchiLocalDatasource._internal();

  static Database? _database;

  factory RealGotchiLocalDatasource() {
    return _instance;
  }
  RealGotchiLocalDatasource._internal();

  Future<Database> _getDatabase() async {
    if (_database != null) return _database!;
    _database = await initializeDB();
    return _database!;
  }

  Future<Database> initializeDB() async {
    var databasesPath = await getDatabasesPath();
    var path = '${databasesPath}gotchi.db';

    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE tasks("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title TEXT NOT NULL,"
            "description TEXT NOT NULL,"
            "executionTime TEXT NOT NULL,"
            "createdAt TEXT NOT NULL,"
            "updatedAt TEXT NOT NULL"
            ")");

        await db.execute("CREATE TABLE reminders("
            "id TEXT PRIMARY KEY,"
            "description TEXT NOT NULL,"
            "date TEXT NOT NULL,"
            "isCompleted INTEGER NOT NULL,"
            "isActive INTEGER NOT NULL"
            ")");
      },
      version: 1,
    );
  }

  // CRUD para la tabla tasks

  Future<int> insertTask(Map<String, dynamic> task) async {
    final Database db = await _getDatabase();
    return await db.insert('tasks', task);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final Database db = await _getDatabase();
    return await db.query('tasks');
  }

  Future<int> updateTask(Map<String, dynamic> task) async {
    final Database db = await _getDatabase();
    return await db
        .update('tasks', task, where: 'id = ?', whereArgs: [task['id']]);
  }

  Future<int> deleteTask(int id) async {
    final Database db = await _getDatabase();
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD para la tabla reminders

  Future<int> insertReminder(Map<String, dynamic> reminder) async {
    final Database db = await _getDatabase();
    return await db.insert('reminders', reminder);
  }

  Future<List<Map<String, dynamic>>> getReminders() async {
    final Database db = await _getDatabase();
    return await db.query('reminders');
  }

  Future<int> updateReminder(Map<String, dynamic> reminder) async {
    final Database db = await _getDatabase();
    return await db.update('reminders', reminder,
        where: 'id = ?', whereArgs: [reminder['id']]);
  }

  Future<int> deleteReminder(String id) async {
    final Database db = await _getDatabase();
    return await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }
}
