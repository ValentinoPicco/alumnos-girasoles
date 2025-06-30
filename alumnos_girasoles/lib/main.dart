import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Root widget
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Instituto Girasoles'),
          centerTitle: true,
        ),
        body: Center(
          child: Builder(
            builder: (context) {
              return Column(
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
        obscureText: true,
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
