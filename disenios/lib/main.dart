import 'dart:io';

import 'package:disenios/src/pages/basico_page.dart';
import 'package:disenios/src/pages/botones_page.dart';
import 'package:disenios/src/pages/scroll_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Para que en android sea transparente y en ios sea blanco
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: (Platform.isAndroid) ? Colors.transparent : Colors.white,
    ));
    //Para ocultar la barra de estado
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños',
      initialRoute: 'botones',
      routes: {
        'basico': (BuildContext context) => BasicoPage(),
        'scroll': (BuildContext context) => ScrollPage(),
        'botones': (BuildContext context) => BotonesPage(),
      },
    );
  }
}
