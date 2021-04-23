import 'package:flutter/material.dart';

class MensajePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notifications app'),
      ),
      body: Center(
        child: Container(
          child: Text('Mensaje Page'),
        ),
      ),
    );
  }
}
