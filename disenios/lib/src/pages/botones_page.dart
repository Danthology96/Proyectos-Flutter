import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BotonesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: [
                _titulos(),
                _botonesRedondeados(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0),
          ],
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
        ),
      ),
    );

    final cajaRosa = Transform.rotate(
      angle: -pi / 4.0,
      child: Container(
        width: 360.0,
        height: 400.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(252, 67, 196, 1.0),
              Color.fromRGBO(249, 139, 166, 1.0),
            ],
            begin: FractionalOffset(0.0, 1.0),
            end: FractionalOffset(1.0, 0.0),
          ),
        ),
      ),
    );

    return Stack(
      children: [
        gradiente,
        Positioned(
          top: -120,
          left: -20,
          child: cajaRosa,
        ),
      ],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clasificar Transacción',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Clasificar esta transacción en una categoría particular',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0))),
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            title: Container(),
          ),
        ],
      ),
    );
  }

  Widget _botonesRedondeados() {
    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.greenAccent, Icons.chat, 'Mensajes'),
            _crearBotonRedondeado(
                Colors.deepPurpleAccent, Icons.alarm, 'Alarmas'),
          ],
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.blue, Icons.border_all, 'General'),
            _crearBotonRedondeado(
                Colors.purpleAccent, Icons.directions_bus, 'Paradas'),
          ],
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.grey, Icons.access_time, 'Cronograma'),
            _crearBotonRedondeado(Colors.yellow, Icons.wb_sunny, 'Clima'),
          ],
        ),
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto) {
    return Container(
      height: 180.0,
      margin: EdgeInsets.all(15.0),
      width: 180.0,
      decoration: BoxDecoration(
          color: Color.fromRGBO(62, 66, 107, 0.7),
          borderRadius: BorderRadius.circular(20.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              CircleAvatar(
                backgroundColor: color,
                radius: 40.0,
                child: Icon(icono, color: Colors.white, size: 30.0),
              ),
              Text(
                texto,
                style: TextStyle(color: color, fontSize: 18.0),
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
