import 'package:flutter/material.dart';

Widget doYouHaveAnAccount(BuildContext context) {
  Widget result = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        '¿Ya tienes una cuenta?',
        style: TextStyle(color: Colors.black),
      ),
      TextButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        child: const Text(
          'Inicia sesión',
          style: TextStyle(color: Colors.amber),
        ),
      ),
    ],
  );
  return result;
}
