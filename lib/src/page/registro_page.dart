import 'package:flutter/material.dart';
import 'package:flutter_crud_example/src/blocs/login_bloc.dart';
import 'package:flutter_crud_example/src/blocs/providers.dart';
import 'package:flutter_crud_example/src/providers/usuarios_provider.dart';
import 'package:flutter_crud_example/src/utils/utils.dart' as utils;

class RegistroPage extends StatelessWidget {
  final usuarioProvider = UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  // fondo de la pantalla
  Widget _crearFondo(BuildContext context) {
    // obtener el tamaño de la pantalla actual
    final size = MediaQuery.of(context).size;

    // fondo morado con gradiente, 40% de la pantalla en la parte superior
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity, // todo el ancho
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0),
      ])),
    );

    // circulo decorativo para el fondo
    final circulo = Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    // logo superior
    final logo = Container(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.store,
            color: Colors.white,
            size: 100,
          ),
          SizedBox(
            height: 10,
            width: double.infinity,
          ), // centrar el widget dentro de su contenedor
          Text(
            'Stock Productos',
            style: TextStyle(color: Colors.white, fontSize: 25),
          )
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,

        // posicionar el circulo en el fondo morado
        Positioned(
          child: circulo,
          top: 90,
          left: 30,
        ),
        Positioned(
          child: circulo,
          top: -40,
          right: -40,
        ),
        Positioned(
          child: circulo,
          bottom: -50,
          right: -10,
        ),
        Positioned(
          child: circulo,
          bottom: 120,
          right: 20,
        ),
        Positioned(
          child: circulo,
          bottom: -50,
          left: -20,
        ),

        logo
      ],
    );
  }

  // formulario de login
  Widget _loginForm(BuildContext context) {
    // instancia de provider bloc
    final bloc = Provider.of(context);

    // obtener el tamaño de la pantalla actual
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      // permite hacer scroll

      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 180,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Crear Cuenta',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 60,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 30,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 50,
                ),
                _crearBoton(bloc, context),
              ],
            ),
          ),
          FlatButton(
            child: Text('¿Ya tienes una cuenta?, Ingresa'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext contex, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.email, color: Colors.deepPurple),
                hintText: 'ejemplo@email.com',
                labelText: 'Correo Electrónico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext contex, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Colors.deepPurple),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext contex, AsyncSnapshot snapshot) {
          return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text('Registrar'),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
          );
        });
  }

  _register(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);
    String mensaje = (info['message'] == null) ? '' : info['message'];

    if (info['ok']) {
      // Navigator.pushReplacementNamed(context, 'home');
    } else {
      utils.mostrarAlerta(context, mensaje, 'Información Erronea');
    }

    print(info['message']);
  }
}
