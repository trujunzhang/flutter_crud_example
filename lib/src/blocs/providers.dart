
import 'package:flutter/material.dart';
import 'package:flutter_crud_example/src/blocs/login_bloc.dart';
import 'package:flutter_crud_example/src/blocs/productos_bloc.dart';

export 'package:flutter_crud_example/src/blocs/login_bloc.dart';
export 'package:flutter_crud_example/src/blocs/productos_bloc.dart';


class Provider extends InheritedWidget {

  // referencias a los blocs
  final _loginBloc = new LoginBloc();
  final _productosBloc = new ProductosBloc();

  static Provider _instancia;

  // sirve para determinar si necesito una nueva instancia de la clase o reutilizar una existente
  factory Provider({Key key, Widget child}) {

    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;

  }

  Provider._internal({Key key, Widget child})
    : super( key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }

  static ProductosBloc productosBloc (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productosBloc;
  }

}