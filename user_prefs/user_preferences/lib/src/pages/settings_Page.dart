import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_preferences/providers/theme_provider.dart';
import 'package:user_preferences/src/share_prefs/user_prefs.dart';
import 'package:user_preferences/widgets/menu_Widget.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode;
  int _gender;
  String _name = 'Daniel';

  TextEditingController _textEditingController;

  final prefs = new UserPrefs();

  @override
  void initState() {
    super.initState();
    prefs.setLastPage = SettingsPage.routeName;
    _gender = prefs.gender;
    _darkMode = prefs.darkMode;
    _textEditingController = new TextEditingController(text: prefs.name);
  }

  @override
  Widget build(BuildContext context) {
    var _themeProvider = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'settings',
              style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SwitchListTile(
            value: _darkMode,
            title: Text('Dark mode'),
            onChanged: (value) {
              setState(() {
                _darkMode = value;
                prefs.setDarkMode = value;
                if (prefs.darkMode) {
                  _themeProvider.setTheme(darkTheme);
                } else {
                  _themeProvider.setTheme(lightTheme);
                }
              });
            },
          ),
          RadioListTile(
            value: 1,
            groupValue: _gender,
            title: Text('Masculino'),
            onChanged: _setSelectedRadio,
          ),
          RadioListTile(
            value: 2,
            groupValue: _gender,
            title: Text('Femenino'),
            onChanged: _setSelectedRadio,
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el móvil',
              ),
              onChanged: (value) {
                prefs.setName = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  _setSelectedRadio(int value) {
    setState(() {
      prefs.setGender = value;
      _gender = value;
    });
  }
}
