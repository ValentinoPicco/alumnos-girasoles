import 'package:alumnos_girasoles/views/login.dart';
import 'package:alumnos_girasoles/views/register.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Ruta de navegación inexistente')),
          ),
        );
    }
  }
}
