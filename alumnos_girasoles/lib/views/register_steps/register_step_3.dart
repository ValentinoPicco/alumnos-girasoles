import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';

class RegisterStep3 extends StatelessWidget {
  final VoidCallback onYes;
  final VoidCallback onNo;
  final VoidCallback onBack;

  const RegisterStep3({
    super.key,
    required this.onYes,
    required this.onNo,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¿Eres responsable de algun grado?',
                style: TextStyle(fontSize: 28.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: onYes, child: const Text('Si')),
                  const SizedBox(width: 10),
                  ElevatedButton(onPressed: onNo, child: const Text('No')),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: onBack, child: const Text('Atrás')),
            ],
          ),
        ),
        doYouHaveAnAccount(context),
        const SizedBox(height: 3),
      ],
    );
  }
}
