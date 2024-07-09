import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'food.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE food(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        calories REAL
      )
      '''
    );
  }

  Future<int> insertFood(Map<String, dynamic> food) async {
    Database db = await database;
    return await db.insert('food', food);
  }

  Future<List<Map<String, dynamic>>> getFoods() async {
    Database db = await database;
    return await db.query('food');
  }

  Future<void> deleteFood(int id) async {
    Database db = await database;
    await db.delete('food', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateFood(int id, Map<String, dynamic> newFood) async {
  Database db = await database;
  await db.update(
    'food',
    newFood,
    where: 'id = ?',
    whereArgs: [id],
  );
}

}
