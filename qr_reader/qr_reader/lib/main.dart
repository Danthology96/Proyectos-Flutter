import 'package:flutter/material.dart';
import 'package:qr_reader/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/mapa_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UIProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider()),
      ],
      child: MaterialApp(
        title: 'QR Reader',
        initialRoute: 'home',
        debugShowCheckedModeBanner: false,
        routes: {
          'home': (_) => HomePage(),
          'mapa': (_) => MapaPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(98, 0, 238, 1),
          accentColor: Color.fromRGBO(98, 0, 238, 1),
          brightness: Brightness.light,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color.fromRGBO(3, 218, 198, 1),
          ),
        ),
        //  PARA EL TEMA OSCURO
        // ThemeData(
        //  primaryColor: Color.fromRGBO(187, 134, 252, 1),
        //   accentColor: Color.fromRGBO(187, 134, 252, 1),
        //   brightness: Brightness.dark,
        //   floatingActionButtonTheme: FloatingActionButtonThemeData(
        //     backgroundColor: Color.fromRGBO(3, 218, 198, 1),
        //   ),
      ),
    );
  }
}
