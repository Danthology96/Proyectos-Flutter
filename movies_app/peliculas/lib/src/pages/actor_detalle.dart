import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/persona_model.dart';
import 'package:peliculas/src/models/providers/peliculas_provider.dart';

class ActorDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final peliculaProvider = new PeliculasProvider();
    final Actor actor = ModalRoute.of(context)!.settings.arguments as Actor;
    print('Actorid' + actor.id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(actor.name!),
      ),
      body: FutureBuilder(
        future: peliculaProvider.getPersona(actor.id.toString()),
        builder: (BuildContext context, AsyncSnapshot<Persona> snapshot) {
          if (snapshot.hasData) {
            Persona persona = snapshot.data!;
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _crearActor(context, persona),
                    _descripcion(context, persona),
                  ],
                ),
              ),
            );
          } else {}
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _descripcion(BuildContext context, Persona persona) {
    String? biografia;
    String nacimiento = '';
    persona.biography == ''
        ? biografia = 'No existe biografía.'
        : biografia = persona.biography;
    persona.birthday == null
        ? nacimiento = nacimiento + 'Sin fecha. '
        : nacimiento = nacimiento + persona.birthday! + '.';
    persona.placeOfBirth == null
        ? nacimiento = nacimiento + 'Lugar de nacimiento no registrado.'
        : nacimiento = nacimiento + persona.placeOfBirth! + '.';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Lugar y fecha de nacimiento: ',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            nacimiento,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Biografía:',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            biografia!,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _crearActor(BuildContext context, Persona persona) {
    String subtitle = '';
    persona.gender == 2 && persona.knownForDepartment == 'Acting'
        ? subtitle = 'Actor '
        : subtitle = 'Actriz';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: persona.id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(persona.getFoto()),
                height: 200.0,
                width: 150.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  persona.name!,
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      persona.popularity.toString(),
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
