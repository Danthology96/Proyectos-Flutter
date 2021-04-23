import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: ListView(
        children: <Widget>[
          _cardTipo1(),
          SizedBox(
            height: 30.0,
          ),
          _cardTipo2(),
          SizedBox(
            height: 30.0,
          ),
        ],
        padding: EdgeInsets.all(10),
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.photo_album,
            color: Colors.blue,
          ),
          title: Text('Soy el título de esta tarjeta'),
          subtitle: Text(
              'Esta es la descripción de la tarjeta, algo que deseo mostrarles'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {},
            ),
          ],
        )
      ]),
    );
  }

  Widget _cardTipo2() {
    final card = Container(
      child: Column(
        children: <Widget>[
          FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(
                'https://static.vecteezy.com/system/resources/thumbnails/000/246/312/original/mountain-lake-sunset-landscape-first-person-view.jpg'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 400.0,
            fit: BoxFit.cover,
          ),
          Container(
              padding: EdgeInsets.all(10.0), child: Text('A ver que pedo')),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0),
          )
        ],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }
}
