import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/';

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
                      const TextFieldEmail(),
                      const SizedBox(height: 8),
                      const TextFieldPassword(),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                        ),
                        onPressed: () {
                          print('Ingresando');
                          singInDocente('email', 'password');
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

  void singInDocente(String email, String password) async {
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
  }
}

class TextFieldEmail extends StatelessWidget {
  const TextFieldEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
      ),
    );
  }
}

class TextFieldPassword extends StatelessWidget {
  const TextFieldPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Contraseña',
        ),
      ),
    );
  }
}
