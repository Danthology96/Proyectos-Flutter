import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String typeSelected = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = new ScanModel(valor: value);
    final id = await DBProvider.db.newScan(newScan);
    //Asigna el id de la base de datos al modelo
    newScan.id = id;

    if (this.typeSelected == newScan.tipo) {
      this.scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllScans();
    //... hace spread de los listados que están ahí, hace un nuevo listado
    this.scans = [...scans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);
    //... hace spread de los listados que están ahí, hace un nuevo listado
    this.scans = [...scans];
    this.typeSelected = type;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    //... hace spread de los listados que están ahí, hace un nuevo listado
    this.loadScansByType(this.typeSelected);
  }
}
