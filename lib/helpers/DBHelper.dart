import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:personeltakipapp/model/PersonelModel.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //public static read only - singleton
  static final DBHelper _dbHelper = DBHelper._internal();
  DBHelper._internal();

  factory DBHelper() {
    return _dbHelper;
  }

  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  //Database dosyasına erişmek için kullanılır.
  Future<Database> initializeDb() async {
    Directory dir = await getTemporaryDirectory();
    String path = dir.path + "burulas001.db";
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  //Database dosyası ilk oluşturulduğunda onCreate çalışır.
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE PERSONEL(ID INTEGER PRIMARY KEY AUTOINCREMENT, TCKIMLIKNO TEXT, ADSOYAD TEXT, CINSIYET TEXT, DOGUMTARIHI TEXT)");
  }

  Future<int?> insertPersonel(PersonelModel model) async {
    Database? db = await this.db;
    return await db?.insert("PERSONEL", model.toMap());
  }
}
