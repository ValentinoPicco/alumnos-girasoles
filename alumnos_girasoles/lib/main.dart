import 'package:alumnos_giasoles/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:alumnos_giasoles/screens/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.routeName,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
