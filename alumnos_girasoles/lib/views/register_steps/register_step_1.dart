import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/widgets/custom_radio_buttons.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';

class RegisterStep1 extends StatelessWidget {
  final String selectedLevel;
  final ValueChanged<String> onLevelChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const RegisterStep1({
    super.key,
    required this.selectedLevel,
    required this.onLevelChanged,
    required this.onNext,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '¿En qué ciclo das clases?',
                style: TextStyle(fontSize: 28.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              CustomRadioButtons(
                options: ["Primer Ciclo", "Segundo Ciclo", "Ambos"],
                onChanged: (value) {
                  switch (value) {
                    case 0:
                      onLevelChanged('lower');
                      break;
                    case 1:
                      onLevelChanged('upper');
                      break;
                    case 2:
                      onLevelChanged('both');
                      break;
                    default:
                  }
                  debugPrint("Seleccionado: $value");
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: onBack, child: const Text('Atrás')),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: onNext,
                    child: const Text('Siguiente'),
                  ),
                ],
              ),
            ],
          ),
        ),
        doYouHaveAnAccount(context),
        const SizedBox(height: 3),
      ],
    );
  }
}
