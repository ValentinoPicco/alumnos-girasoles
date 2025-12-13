import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';
import 'package:alumnos_girasoles/routes/app_router.dart';

class RegisterStep4 extends StatelessWidget {
  const RegisterStep4({super.key});

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
                    "¿De que grade eres responsable?",
                    style: TextStyle(fontSize: 28.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        for (
                          var i = 0;
                          i < registerProvider.selectedGrades.length;
                          i++
                        ) ...[
                          RadioListTile<String>(
                            title: Text(
                              registerProvider.selectedGrades
                                      .toList()[i][0]
                                      .toUpperCase() +
                                  registerProvider.selectedGrades
                                      .toList()[i]
                                      .substring(1),
                            ),
                            value: registerProvider.selectedGrades.toList()[i],
                            groupValue: registerProvider.responsibleGrade,
                            activeColor: Colors.amberAccent,
                            controlAffinity: ListTileControlAffinity.trailing,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(width: 1),
                            ),
                            onChanged: (value) {
                              registerProvider.setResponsibleGrade(value);
                            },
                          ),
                          if (i < registerProvider.selectedGrades.length - 1)
                            const SizedBox(height: 8),
                        ],
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.registerStep3Route,
                          );
                        },
                        child: const Text('Atrás'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.registerStep5Route,
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
