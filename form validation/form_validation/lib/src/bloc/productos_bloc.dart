import 'dart:io';

import 'package:form_validation/providers/productos_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:form_validation/src/models/producto_model.dart';

class ProductosBloc {
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargaController = new BehaviorSubject<bool>();

  final _productosProvider = new ProductosProvider();

  Stream<List<ProductoModel>> get productosStream =>
      _productosController.stream;
  Stream<bool> get cargando => _cargaController.stream;

  void cargarProductos() async {
    final productos = await _productosProvider.cargarProductos();
    _productosController.sink.add(productos);
  }

  void agregarProducto(ProductoModel producto) async {
    _cargaController.sink.add(true);
    await _productosProvider.crearProducto(producto);
    _cargaController.sink.add(false);
  }

  Future<String> subirFoto(File foto) async {
    _cargaController.sink.add(true);
    final fotoURL = await _productosProvider.subirImagen(foto);
    _cargaController.sink.add(false);

    return fotoURL;
  }

  void editarProducto(ProductoModel producto) async {
    _cargaController.sink.add(true);
    await _productosProvider.editarProducto(producto);
    _cargaController.sink.add(false);
  }

  void borrarProducto(String id) async {
    await _productosProvider.borrarProducto(id);
  }

  dispose() {
    _cargaController?.close();
    _productosController?.close();
  }
}
