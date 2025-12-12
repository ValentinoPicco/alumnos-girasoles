import 'package:alumnos_girasoles/routes/app_router.dart';
import 'package:alumnos_girasoles/views/register.dart';
import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/views/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(); // cargamos el .env

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(MyApp());
}

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
