import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scanTiles.dart';

class DireccionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipo: 'http');
  }
}
