import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_preferences/providers/theme_provider.dart';
import 'package:user_preferences/src/pages/home_Page.dart';
import 'package:user_preferences/src/pages/settings_Page.dart';
import 'package:user_preferences/src/share_prefs/user_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPrefs();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _initialTheme()),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  final prefs = new UserPrefs();
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Preferences',
      initialRoute: prefs.lastPage,
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        SettingsPage.routeName: (BuildContext context) => SettingsPage(),
      },
      theme: theme.getTheme,
    );
  }
}

ThemeChanger _initialTheme() {
  final prefs = new UserPrefs();
  if (prefs.darkMode) {
    return ThemeChanger(darkTheme);
  } else {
    return ThemeChanger(lightTheme);
  }
}
