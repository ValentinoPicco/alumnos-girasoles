import 'package:flutter/material.dart';

Widget doYouHaveAnAccount() {
  Widget result = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('¿Ya tienes una cuenta? Inicia sesión'),
      TextButton(
        onPressed: () {
          print('Vuelve a la pantalla de login');
        },
        child: const Text('Aquí', style: TextStyle(color: Colors.black)),
      ),
    ],
  );
  return result;
}
