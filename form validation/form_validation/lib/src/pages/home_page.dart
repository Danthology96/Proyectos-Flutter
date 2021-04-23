import 'package:flutter/material.dart';
import 'package:form_validation/providers/productos_provider.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/preferencias_usuario/preferencias_usuario.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final productosBloc = Provider.productosBLoc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        actions: [
          _logoutButton(context),
        ],
      ),
      body: _crearLista(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, 'producto')
          .then((value) => setState(() {})),
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
    );
  }

  Widget _crearLista(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
          );
        }

        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) =>
                _crearItem(context, productosBloc, productos[i]),
          );
        }
      },
    );
  }

  IconButton _logoutButton(BuildContext context) {
    if (_prefs.token == '') {
      // Icono login
      return IconButton(
          icon: Icon(
            Icons.account_box,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');
          });
    } else {
      // Icono logout
      return IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            _prefs.token = '';
            Navigator.pushReplacementNamed(context, 'login');
            setState(() {});
          });
    }
  }

  Widget _crearItem(BuildContext context, ProductosBloc productosBloc,
      ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) => productosBloc.borrarProducto(producto.id),
      child: Card(
        child: Column(
          children: [
            (producto.fotoUrl == null)
                ? Image(
                    image: AssetImage('assets/no-image.png'),
                  )
                : FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(producto.fotoUrl),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text('${producto.id}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'producto', arguments: producto)
                      .then((value) => setState(() {})),
            ),
          ],
        ),
      ),
    );
  }
}
