import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MultiWalletDatabase {
  MultiWalletDatabase._();
  static final MultiWalletDatabase db = MultiWalletDatabase._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "MultiWalletDatabase.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE MultiWalletTable (id INTEGER PRIMARY KEY, walletName TEXT, walletAddress TEXT,tronWalletaddress TEXT, phraseSeed TEXT, privateKey TEXT)');
    });
  }

  Future getAllWallets() async {
    final db = await database;

    List list = await db!.rawQuery('SELECT * FROM MultiWalletTable');

    return list;
  }

  Future<int> countWallets() async {
    final db = await database;
    var count = Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM MultiWalletTable'));
    return count as int;
  }

  Future<MultiWalletDatabaseModel?> getWalletById(int id) async {
    final db = await database;
    var result =
        await db!.query("MultiWalletTable", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty
        ? MultiWalletDatabaseModel.fromMap(result.first)
        : null;
  }

  Future<MultiWalletDatabaseModel?> getWalletByWalletName(
      String walletName) async {
    final db = await database;
    var result = await db!.query("MultiWalletTable",
        where: "walletName = ?", whereArgs: [walletName]);
    return result.isNotEmpty
        ? MultiWalletDatabaseModel.fromMap(result.first)
        : null;
  }

  insert(int id, String walletName, String walletAddress, String tronwallet,
      String phraseSeed, String privateKey) async {
    final db = await database;
    var result = await db!.rawInsert(
        "INSERT INTO MultiWalletTable ('id', 'walletName', 'walletAddress','tronWalletaddress', 'phraseSeed', 'privateKey')"
        " VALUES (?, ?, ?, ?, ?, ?)",
        [id, walletName, walletAddress, tronwallet, phraseSeed, privateKey]);
    return result;
  }

  update(MultiWalletDatabaseModel model) async {
    final db = await database;
    var result = await db!.update("MultiWalletTable", model.toMap(),
        where: "id = ?", whereArgs: [model.id]);
    return result;
  }

  delete(int id) async {
    final db = await database;
    db!.delete("MultiWalletTable", where: "id = ?", whereArgs: [id]);
  }

  deleteList() async {
    final db = await database;
    db!.delete("MultiWalletTable");
  }
}

class MultiWalletDatabaseModel {
  int id;
  String walletName;
  String walletAddress;
  String tronWalletaddress;
  String phraseSeed;
  String privateKey;

  MultiWalletDatabaseModel({
    required this.id,
    required this.walletName,
    required this.walletAddress,
    required this.tronWalletaddress,
    required this.phraseSeed,
    required this.privateKey,
  });

  MultiWalletDatabaseModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        walletName = res['walletName'],
        walletAddress = res['walletAddress'],
        tronWalletaddress = res['tronWalletaddress'],
        phraseSeed = res['phraseSeed'],
        privateKey = res['privateKey'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'walletName': walletName,
      'walletAddress': walletAddress,
      'tronWalletaddress': tronWalletaddress,
      'phraseSeed': phraseSeed,
      'privateKey': privateKey,
    };
  }
}
