import 'dart:convert';

import 'package:flutter_crud_example/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;


class UsuarioProvider {

  final String _firebaseToken = 'AIzaSyBaHuI7_Zdzz17uOGhZNI7VzC-mcj_kfyI';
  final _prefs = new PreferenciasUsuario();


  Future<Map<String, dynamic>> login(String email, String password) async {

    final authData =  {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: jsonEncode(authData)
    );

    Map<String, dynamic> decodedResp = jsonDecode(resp.body);

    // print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
      _prefs.token = decodedResp['idToken'];
      return { 'ok': true, 'token': decodedResp['idToken'] };
    } else {
      return { 'ok': false, 'message': decodedResp['error']['message'] };
    }


  }

  Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async {

    final authData =  {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: jsonEncode(authData)
    );

    Map<String, dynamic> decodedResp = jsonDecode(resp.body);

    // print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
      _prefs.token = decodedResp['idToken'];
      return { 'ok': true, 'token': decodedResp['idToken'] };
    } else {
      return { 'ok': false, 'message': decodedResp['error']['message'] };
    }


  }

}