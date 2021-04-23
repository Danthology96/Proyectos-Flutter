import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_validation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyDoJpyM1bepSlJvidzdMoY8mJCNpxZ0eKc';
  final _prefs = new PreferenciasUsuario();

  // Future<Map<String, dynamic>> login(String email, String password) async {
  //   final Uri _url = Uri.parse(
  //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken');

  //   final authData = {
  //     'email': email,
  //     'password': password,
  //     'returnSecureToken': true,
  //   };

  //   final resp = await http.post(_url, body: json.encode(authData));

  //   Map<String, dynamic> decodedResp = json.decode(resp.body);
  //   print(decodedResp);

  //   if (decodedResp.containsKey('idToken')) {
  //     //TODO: Salvar el token en el storage
  //     _prefs.token = decodedResp['idToken'];
  //     return {'ok': true, 'idToken': decodedResp['idToken']};
  //   } else {
  //     return {'ok': false, 'mensaje': decodedResp['error']['message']};
  //   }
  // }
  //

  Future<Map<String, dynamic>> login(String email, String password) async {
    await Firebase.initializeApp();
    String token = '';
    try {
      //Para realizar el login a través de firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((currentUser) async {
        token = await currentUser.user.getIdToken();
        _prefs.token = token;
        print("prefs token: " + _prefs.token);
      });
      print(userCredential);
      return {'ok': true, 'idToken': token};
    } catch (e) {
      print(e);
      return {'ok': false, 'mensaje': e.toString()};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final Uri _url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken');

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(_url, body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'idToken': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
