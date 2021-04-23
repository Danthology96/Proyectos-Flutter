import 'package:form_validation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {
  final String _url = 'https://flutter-2e23d-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = Uri.https(_url, 'Productos.json');

    final resp = await http.post(url, body: productoModelToJson(producto));
  }
}
