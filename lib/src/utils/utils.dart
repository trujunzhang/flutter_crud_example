import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje, String titulo) {
  String msj = '';

  switch (mensaje) {
    case 'EMAIL_NOT_FOUND':
      msj = 'Email o password incorrectos.';
      break;
    case 'INVALID_PASSWORD':
      msj = 'Email o password incorrectos.';
      break;
    case 'EMAIL_EXISTS':
      msj = 'El email ingresado no está disponible.';
      break;
    default:
      msj = 'Se ha producido un error. $mensaje';
      break;
  }

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20),
          elevation: 20,
          content: Text(
            msj,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Ok')),
          ],
        );
      });
}
