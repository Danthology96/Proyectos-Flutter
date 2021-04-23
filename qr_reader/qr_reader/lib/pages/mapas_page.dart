import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scanTiles.dart';

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipo: 'geo');
  }
}
