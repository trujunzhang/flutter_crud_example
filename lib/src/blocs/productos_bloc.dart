


import 'dart:io';

import 'package:flutter_crud_example/src/models/producto_model.dart';
import 'package:flutter_crud_example/src/providers/productos_providers.dart';
import 'package:rxdart/subjects.dart';

class ProductosBloc {

  // Se definen los controllers
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  // se necesita una referencia los providers para realizar desde aca las peticiones
  final _productosProvider = new ProductosProvider();

  // Retornamos los Stream
  Stream<List<ProductoModel>> get productosStream => _productosController.stream;
  Stream<bool> get cargandoStream => _cargandoController.stream;

  // Implementar métodos

  // cargar 
  void cargarProductos() async {

    // obtengo los productos desde el provider
    final productos = await _productosProvider.cargarProductos();

    // inserto los productos obtenidos en el Stream
    _productosController.sink.add(productos);

  }

  // agregar producto
  void crearProducto( ProductoModel producto) async {

    // indico que estoy procesando
    _cargandoController.sink.add(true);

    // inserto el producto
    await _productosProvider.crearProducto(producto);

    // indico que termino el procesamiento
    _cargandoController.sink.add(false);

  }

   // agregar foto
  Future<String> subirFoto( File foto) async {

    // inserto el producto
    final fotoUrl = await _productosProvider.subirImagen(foto);

    return fotoUrl;

  }

  // editar producto
  void editarProducto( ProductoModel producto) async {

    // indico que estoy procesando
    _cargandoController.sink.add(true);

    // editar el producto
    await _productosProvider.editarProducto(producto);

    // indico que termino el procesamiento
    _cargandoController.sink.add(false);

  }

  // editar producto
  void borrarProducto( String id) async {

    await _productosProvider.borrarProducto(id);

  }




  // para cerrar los controllers luego de utilizarlos
  dispose() {

    // El operador "?" permite verificar si esta cargado el controller
    _productosController?.close();
    _cargandoController?.close();
  }

}