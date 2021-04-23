import 'package:flutter/material.dart';
import 'package:user_preferences/src/share_prefs/user_prefs.dart';
import 'package:user_preferences/widgets/menu_Widget.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';
  final prefs = new UserPrefs();
  @override
  Widget build(BuildContext context) {
    // prefs.initPrefs();
    prefs.setLastPage = HomePage.routeName;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Preferences'),
      ),
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Dark mode:${prefs.darkMode}'),
          Divider(),
          Text('Gender: ${prefs.gender}'),
          Divider(),
          Text('Username: ${prefs.name}'),
          Divider(),
        ],
      ),
    );
  }
}
