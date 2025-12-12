import 'package:flutter/material.dart';

Widget doYouHaveAnAccount(BuildContext context) {
  Widget result = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('¿Ya tienes una cuenta? Inicia sesión'),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Aquí', style: TextStyle(color: Colors.black)),
      ),
    ],
  );
  return result;
}
