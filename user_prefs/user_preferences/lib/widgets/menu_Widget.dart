import 'package:flutter/material.dart';
import 'package:user_preferences/src/pages/home_Page.dart';
import 'package:user_preferences/src/pages/settings_Page.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/iceberg-minimalism-7v.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text('Home Page'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.ac_unit,
              color: Colors.blue,
            ),
            title: Text('AC'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            title: Text('Settings'),
            onTap: () {
              // Navigator.pop(context);
              // Navigator.pushNamed(context, SettingsPage.routeName);
              Navigator.pushReplacementNamed(context, SettingsPage.routeName);
            },
          )
        ],
      ),
    );
  }
}
