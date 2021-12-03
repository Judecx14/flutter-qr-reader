import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String tipoSeleccionado = '';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id = id;
    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScans() async {
    final scansFromDB = await DBProvider.db.getScans();
    scans = scansFromDB;
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scansFromDB = await DBProvider.db.getScanByTipo(tipo);
    scans = scansFromDB;
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  borrarScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    //cargarScansPorTipo(tipoSeleccionado);
  }
}
