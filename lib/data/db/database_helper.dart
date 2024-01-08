import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

   DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorit = 'favorit';

    Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/retaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorit (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating REAL
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async{
     if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertFavorit(Restaurant restaurant) async{
    final db = await database;
    await db!.insert(_tblFavorit, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorit() async{
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblFavorit);

    return result.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoritById(String id) async{
    final db = await database;

    List<Map<String, dynamic>> result = await db!.query(
      _tblFavorit,
      where: 'id = ?',
      whereArgs: [id],
    );

    if(result.isNotEmpty){
      return result.first;
    }else{
      return{};
    }
  }

  Future<void> removeFavorit(String id) async{
    final db = await database;

    await db!.delete(
      _tblFavorit,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}