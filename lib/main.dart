import 'package:flutter/material.dart';
import 'package:flutter_crud_example/src/blocs/providers.dart';
import 'package:flutter_crud_example/src/page/home_page.dart';
import 'package:flutter_crud_example/src/page/login_page.dart';
import 'package:flutter_crud_example/src/page/producto_page.dart';
import 'package:flutter_crud_example/src/page/registro_page.dart';
import 'package:flutter_crud_example/src/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final matApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'registro': (BuildContext context) => RegistroPage(),
        'home': (BuildContext context) => HomePage(),
        'producto': (BuildContext context) => ProductoPage(),
      },
      theme: _themeApp(),
    );

    // Es un widget que almacena información, se utiliza con el patrón bloc
    // el el padre de todos los widget y sus hijos piden información desde abajo
    return Provider(
      child: matApp,
    );
  }

  ThemeData _themeApp() {
    return ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Colors.deepPurple,
      accentColor: Colors.purple,

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        title: TextStyle(fontSize: 26.0, color: Colors.white),
        body1: TextStyle(
          fontSize: 14.0,
        ),
        button: TextStyle(fontSize: 14.0, color: Colors.white),
        display1: TextStyle(
            fontSize: 13.0, fontFamily: 'Hind', color: Colors.black26),
      ),
    );
  }
}
