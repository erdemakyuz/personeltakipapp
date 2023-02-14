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
    String path = dir.path + "burulas003.db";
    return await openDatabase(path,
        version: 3, onCreate: _createDb, onUpgrade: _onUpgrade);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    //Yeni bir field eklenmesi gerekiyorsa versiyon kontrolü yapılarak ekleniyor.
    if (oldVersion < 2) {
      if (!await columnExists(db, "PERSONEL", "TELEFON")) {
        await db.execute("ALTER TABLE PERSONEL ADD COLUMN TELEFON TEXT");
      }
    }
    if (oldVersion < 3) {
      if (!await columnExists(db, "PERSONEL", "RESIMYOLU")) {
        await db.execute("ALTER TABLE PERSONEL ADD COLUMN RESIMYOLU TEXT");
      }
    }
  }

  //Database dosyası ilk defa oluşturulduğunda onCreate çalışır.
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE PERSONEL(ID INTEGER PRIMARY KEY AUTOINCREMENT, TCKIMLIKNO TEXT, ADISOYADI TEXT, CINSIYET TEXT, DOGUMTARIHI TEXT)");
    //Create işleminden sonrada varsa updateleri mutlaka çalıştırıyoruz.
    _onUpgrade(db, 0, newVersion);
  }

  Future<bool> tableExists(Database db, String name) async {
    var result = await db.rawQuery(
        "SELECT count(*) AS Result FROM sqlite_master WHERE type='table' AND name='" +
            name +
            "'",
        null);

    if (result[0]["Result"] != null &&
        int.parse(result[0]["Result"].toString()) > 0) {
      return true;
    }

    return false;
  }

  Future<bool> columnExists(
      Database db, String tableName, String columnName) async {
    if (await tableExists(db, tableName)) {
      var result =
          await db.rawQuery("PRAGMA table_info(" + tableName + ")", null);
      for (var column in result) {
        if (column.values.first == columnName) {
          return true;
        }
      }
    }
    return false;
  }

  //Personel Model İşlemleri
  Future<int?> insertPersonel(PersonelModel model) async {
    Database? db = await this.db;
    //db.execute("insert into PERSONEL(TCKIMLIKNO,ADISOYADI) values('${model.ADISOYADI}','${model.TCKIMLIKNO}')");
    return await db?.insert("PERSONEL", model.toMap());
  }

  Future<int?> updatePersonel(PersonelModel model) async {
    Database? db = await this.db;
    //db.execute("insert into PERSONEL(TCKIMLIKNO,ADISOYADI) values('${model.ADISOYADI}','${model.TCKIMLIKNO}')");
    return await db?.update(
        "PERSONEL", where: "ID= ?", whereArgs: [model.ID], model.toMap());
  }

  Future<List<PersonelModel>> getPersonelList() async {
    List<PersonelModel> liste = List<PersonelModel>.empty(growable: true);
    Database? db = await this.db;
    var result = await db?.rawQuery("select * from PERSONEL order BY ID DESC");
    result?.forEach((element) {
      liste.add(PersonelModel.fromObject(element));
    });
    return liste;
  }
}
