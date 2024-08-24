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
        db.execute("CREATE TABLE gotchi(");
      },
    );
  }
}
