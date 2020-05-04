import 'package:flutter/material.dart';
import 'package:flutter_crud_example/src/blocs/providers.dart';
import 'package:flutter_crud_example/src/models/producto_model.dart';

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Home Page',
        style: Theme.of(context).textTheme.title,
      )),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.pushNamed(context, 'producto'));
  }

  Widget _crearListado(ProductosBloc bloc) {
    // se utiliza un StreamBuilder para utilizar el bloc
    return StreamBuilder(
      stream: bloc.productosStream ,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if (snapshot.hasData) {
            final productos = snapshot.data;

            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, i) => _crearItem(context, bloc, productos[i]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductosBloc bloc, ProductoModel producto) {
    return Dismissible(
      background: Container(color: Colors.red),
      onDismissed: (direccion) => bloc.borrarProducto(producto.id),
      key: UniqueKey(),
      child: Card(
        child: Column(
          children: <Widget>[
            // utilizamos un operador ternario para determinar si hay imagen que mostrar
            (producto.fotoUrl == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    placeholder: AssetImage('assets/loading.gif'),
                    image: NetworkImage(producto.fotoUrl),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover),
            ListTile(
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text(producto.id),
              onTap: () =>
                  Navigator.pushNamed(context, 'producto', arguments: producto),
            )
          ],
        ),
      ),
    );
  }
}
