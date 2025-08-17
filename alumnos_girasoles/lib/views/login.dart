import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:alumnos_girasoles/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instituto Girasoles'),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Iniciar Sesión',
                        style: TextStyle(fontSize: 28.0),
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        labelText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        labelText: 'Contraseña',
                        obscureText: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                        ),
                        onPressed: () {
                          print('Ingresando');
                          signInDocente(
                            emailController.text,
                            passwordController.text,
                          );
                        },
                        child: const Text(
                          'Ingresar',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿Todavía no te registraste?'),
                    TextButton(
                      onPressed: () {
                        print('Ir a registrarse');
                      },
                      child: const Text(
                        'Hazlo Aquí',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void signInDocente(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        print('Ingresaste con éxito: ${response.user!.email}');
        // Podés redirigir a otra pantalla o mostrar mensaje
      } else if (response.session == null) {
        print('Registro incompleto, falta confirmar el email');
      } else {
        print('Error: ${response}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

void signInDocente(String email, String password) async {
  try {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user != null) {
      print('Ingresaste con éxito: ${response.user!.email}');
      // Podés redirigir a otra pantalla o mostrar mensaje
    } else if (response.session == null) {
      print('Registro incompleto, falta confirmar el email');
    } else {
      print('Error: ${response}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
