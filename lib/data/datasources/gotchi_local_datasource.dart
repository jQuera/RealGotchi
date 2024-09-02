import 'package:sqflite/sqflite.dart';

class RealGotchiLocalDatasource {
  static final RealGotchiLocalDatasource _instance = RealGotchiLocalDatasource._internal();

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
            "id TEXT PRIMARY KEY,"
            "title TEXT NOT NULL,"
            "description TEXT NOT NULL,"
            "executionTime TEXT NOT NULL,"
            "type INTEGER NOT NULL,"
            "createdAt TEXT NOT NULL,"
            "updatedAt TEXT NOT NULL,"
            "daysOfWeek TEXT NOT NULL" // Agregamos la columna daysOfWeek
            ")");

        await db.execute("CREATE TABLE reminders("
            "id TEXT PRIMARY KEY,"
            "description TEXT NOT NULL,"
            "date TEXT NOT NULL,"
            "isCompleted INTEGER NOT NULL,"
            "isActive INTEGER NOT NULL,"
            "taskId TEXT NOT NULL" // Agregamos la columna taskId
            ")");
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute("ALTER TABLE tasks ADD COLUMN type INTEGER NOT NULL DEFAULT 0");
        }
        if (oldVersion < 4) {
          await db.execute("ALTER TABLE tasks ADD COLUMN daysOfWeek TEXT NOT NULL DEFAULT ''");
        }
        if (oldVersion < 5) {
          await db.execute("ALTER TABLE reminders ADD COLUMN taskId TEXT NOT NULL DEFAULT ''");
        }
      },
      version: 5, // Aumentamos la versión de la base de datos
    );
  }

  // CRUD para la tabla tasks

  Future<String> insertTask(Map<String, dynamic> task) async {
    final Database db = await _getDatabase();
    await db.insert('tasks', task);
    return task['id'] as String;
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final Database db = await _getDatabase();
    return await db.query('tasks');
  }

  Future<int> updateTask(Map<String, dynamic> task) async {
    final Database db = await _getDatabase();
    return await db.update('tasks', task, where: 'id = ?', whereArgs: [task['id']]);
  }

  Future<int> deleteTask(String id) async {
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
    return await db.update('reminders', reminder, where: 'id = ?', whereArgs: [reminder['id']]);
  }

  Future<int> deleteReminder(String id) async {
    final Database db = await _getDatabase();
    return await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }
}
