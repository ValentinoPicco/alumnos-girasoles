import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';
import 'package:alumnos_girasoles/routes/app_router.dart';

class RegisterStep3 extends StatelessWidget {
  const RegisterStep3({super.key});

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
                      ElevatedButton(
                        onPressed: () {
                          registerProvider.setResponsibleTeacher(true);
                          Navigator.pushNamed(
                            context,
                            AppRouter.registerStep4Route,
                          );
                        },
                        child: const Text('Si'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          registerProvider.setResponsibleTeacher(false);
                          Navigator.pushNamed(
                            context,
                            AppRouter.registerStep5Route,
                          );
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.registerStep2Route,
                      );
                    },
                    child: const Text('Atrás'),
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
