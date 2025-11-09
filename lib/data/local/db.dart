import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), "hidra.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Tabla de usuarios
        await db.execute("""
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT UNIQUE,
            password TEXT
          )
        """);

        // Tabla de registros de agua
        await db.execute("""
          CREATE TABLE water_records (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            vasos INTEGER
          )
        """);
      },
    );
  }
}
