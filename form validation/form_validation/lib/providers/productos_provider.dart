import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:form_validation/src/models/producto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_validation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {
  // final String _url = 'https://flutter-2e23d-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    // final url = Uri.https(_url, 'Productos.json');
    //para el firestore
    await Firebase.initializeApp();
    final FirebaseFirestore databaseReference = FirebaseFirestore.instance;
    //devuelve Productos/isPDT3IwhPBtq8tDqCVC (el id del producto insertado)
    final result =
        await databaseReference.collection('Productos').add(producto.toJson());

    print('Result :' + result.id);
    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    await Firebase.initializeApp();
    CollectionReference productos =
        FirebaseFirestore.instance.collection('Productos');

    productos.doc(producto.id).update(producto.toJson());
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    await Firebase.initializeApp();

    final List<ProductoModel> productosList = new List();

    await FirebaseFirestore.instance
        .collection('Productos')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final prodTemp = new ProductoModel();
        prodTemp.id = doc.id;
        prodTemp.titulo = doc["titulo"];
        prodTemp.valor = doc["valor"];
        prodTemp.disponible = doc["disponible"];
        prodTemp.fotoUrl = doc["fotoURL"];
        print(prodTemp.toJson());

        productosList.add(prodTemp);
      });
    });

    return productosList;
  }

  Future<int> borrarProducto(String id) async {
    int success = 0;
    await Firebase.initializeApp();

    CollectionReference productos =
        FirebaseFirestore.instance.collection('Productos');

    productos
        .doc(id)
        .delete()
        .then((value) => (success = 1))
        .catchError((error) => print("Error al borrar usuario: $error"));
    return success;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dh0p43nj1/image/upload?upload_preset=uit7xma5');

    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final respuesta = await http.Response.fromStream(streamResponse);

    if (respuesta.statusCode != 200 && respuesta != 201) {
      print('Algo salió mal');
      print(respuesta.body);
      return null;
    }

    final respData = json.decode(respuesta.body);
    print(respData);
    return respData['secure_url'];
  }
}
