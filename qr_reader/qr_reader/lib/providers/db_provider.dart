import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  static Database _database;
  //el ._() es un constructor privado (singleton)
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    //Path donde se almacena la BD
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //Crear DB
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE Scans(
        id INTEGER PRIMARY KEY,
        tipo TEXT,
        valor TEXT
        ) 
      ''');
    });
  }

  //2da FORMA Y BUENA
  newScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    print(res);
    //ES EL ID DEL ÚLTIMO REGISTRO INSERTADO
    return res;
  }

  Future<ScanModel> getScanById(int i) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [i]);
    print(res);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    print(res);
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [type]);
    print(res);
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update('Scans', newScan.toJson(),
        where: 'id = ?', whereArgs: [newScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}
