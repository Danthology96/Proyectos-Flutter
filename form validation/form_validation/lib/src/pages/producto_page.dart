import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductosBloc productosBloc;

  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBLoc(context);
    final ProductoModel prodArgs = ModalRoute.of(context).settings.arguments;

    if (prodArgs != null) {
      producto = prodArgs;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual_outlined),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Ingrese sólo valores numéricos';
        }
      },
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
      icon: Icon(Icons.save_outlined),
      label: Text('Guardar'),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
          color: Colors.white,
        )),
      ),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    //si no es valido retorna
    if (!formKey.currentState.validate()) return;
    //dispara el save de todos los textformfields del formulario y guarda
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      producto.fotoUrl = await productosBloc.subirFoto(foto);
    }

    if (producto.id == null) {
      productosBloc.agregarProducto(producto);
    } else {
      productosBloc.editarProducto(producto);
    }

    Timer(Duration(seconds: 2), () {
      setState(() {
        _guardando = false;
        Navigator.pushReplacementNamed(context, 'home');
      });
    });

    mostrarSnackbar('Guardando producto');
  }

  void mostrarSnackbar(String msg) {
    final snackBar = new SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 1500),
      action: SnackBarAction(
        label: 'VOLVER',
        textColor: Colors.white,
        onPressed: () => Navigator.pop(context, 'home'),
      ),
      backgroundColor: Colors.deepPurple,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(producto.fotoUrl),
        height: 300,
        fit: BoxFit.contain,
      );
    } else {
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: origen);
    foto = File(pickedFile.path);

    if (foto != null) {
      producto.fotoUrl = null;
    }

    setState(() {});
  }
}
