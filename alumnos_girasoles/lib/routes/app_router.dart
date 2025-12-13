import 'package:alumnos_girasoles/views/login.dart';
import 'package:alumnos_girasoles/views/register/register_entry.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_0.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_1.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_2.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_3.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_4.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_5.dart';
import 'package:alumnos_girasoles/views/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String loginRoute = '/';
  static const String registerRoute = '/register';
  static const String registerStep0Route = '/register/step0';
  static const String registerStep1Route = '/register/step1';
  static const String registerStep2Route = '/register/step2';
  static const String registerStep3Route = '/register/step3';
  static const String registerStep4Route = '/register/step4';
  static const String registerStep5Route = '/register/step5';
  static const String homeRoute = '/home';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterEntry());
      case registerStep0Route:
        return MaterialPageRoute(builder: (_) => RegisterStep0());
      case registerStep1Route:
        return MaterialPageRoute(builder: (_) => RegisterStep1());
      case registerStep2Route:
        return MaterialPageRoute(builder: (_) => RegisterStep2());
      case registerStep3Route:
        return MaterialPageRoute(builder: (_) => RegisterStep3());
      case registerStep4Route:
        return MaterialPageRoute(builder: (_) => RegisterStep4());
      case registerStep5Route:
        return MaterialPageRoute(builder: (_) => RegisterStep5());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Ruta de navegación inexistente')),
          ),
        );
    }
  }
}
