import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = 'gastro-go.db';
  static const String _tableName = 'restaurant';
  static const int _databaseVersion = 1;


  Future<void> createTables(Database database) async {
    await database.execute(
      """
        CREATE TABLE $_tableName(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating REAL
        )
      """
    );
  }

  Future<Database> _intializeDb() async {
    return openDatabase(
      _databaseName, 
      version: _databaseVersion,
      onCreate: (Database database, int version) async {
        await createTables(database);
      }
    );
  }

  Future<int> insertItem(RestaurantData restaurant) async {
    final db = await _intializeDb();

    final data = restaurant.toJson();
    final id = await db.insert(
      _tableName, 
      data,
      conflictAlgorithm: ConflictAlgorithm.replace
    );

    return id;
  }

  Future<List<RestaurantData>> getAllData() async {
    final db = await _intializeDb();
    final results = await db.query(_tableName,);
    
    return results.map((result)=> RestaurantData.fromJson(result)).toList();
  }

  Future<RestaurantData> getDataId(String id) async {
    final db = await _intializeDb();
    final results = await db.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1
    );

    return results.map((result)=> RestaurantData.fromJson(result)).first;
  }

  Future<String> removeItem(String id) async {
    final db = await _intializeDb();
    final result = await db.delete(
      _tableName, 
      where: "id = ?",
      whereArgs: [id]
    );

    return result.toString();
  }
}