import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text('Instituto Girasoles'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8.0,
              children: [
                const Text('Iniciar Sesión'),
                const SizedBox(height: 15),
                const TextFieldDNI(),
                const TextFieldPassword(),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  onPressed: () {
                    print('Click!');
                  },
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TextFieldDNI extends StatelessWidget {
  const TextFieldDNI({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'DNI',
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
