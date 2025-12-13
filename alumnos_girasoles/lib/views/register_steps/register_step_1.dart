import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/widgets/custom_radio_buttons.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';
import 'package:alumnos_girasoles/routes/app_router.dart';

class RegisterStep1 extends StatelessWidget {
  const RegisterStep1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, registerProvider, _) {
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
                          registerProvider.setLevel('lower');
                          break;
                        case 1:
                          registerProvider.setLevel('upper');
                          break;
                        case 2:
                          registerProvider.setLevel('both');
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.registerStep0Route,
                          );
                        },
                        child: const Text('Atrás'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.registerStep2Route,
                          );
                        },
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
      },
    );
  }
}
