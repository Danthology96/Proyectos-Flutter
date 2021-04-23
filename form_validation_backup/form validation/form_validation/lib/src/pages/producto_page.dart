import 'package:flutter/material.dart';
import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();

  ProductoModel producto = new ProductoModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () {},
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
      onPressed: _submit,
    );
  }

  void _submit() {
    //si no es valido retorna
    if (!formKey.currentState.validate()) return;
    //dispara el save de todos los textformfields del formulario y guarda
    formKey.currentState.save();
    print('Todo ok!');

    print(producto.titulo);
    print(producto.valor);
    print(producto.disponible);
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
}
