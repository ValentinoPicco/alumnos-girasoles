import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';
import 'package:alumnos_girasoles/routes/app_router.dart';

class RegisterStep2 extends StatelessWidget {
  const RegisterStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, registerProvider, _) {
        // Filtramos grados según el ciclo
        List<String> gradesToShow;
        if (registerProvider.selectedLevel == 'lower') {
          gradesToShow = registerProvider.orderedGrades.sublist(0, 3);
        } else if (registerProvider.selectedLevel == 'upper') {
          gradesToShow = registerProvider.orderedGrades.sublist(3, 6);
        } else {
          gradesToShow = registerProvider.orderedGrades;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '¿En qué grados das clases?',
                    style: TextStyle(fontSize: 28.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: gradesToShow.map((grade) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: CheckboxListTile(
                            value: registerProvider.selectedGrades.contains(
                              grade,
                            ),
                            onChanged: (bool? checked) {
                              final newGrades = Set<String>.from(
                                registerProvider.selectedGrades,
                              );
                              if (checked == true) {
                                newGrades.add(grade);
                              } else {
                                newGrades.remove(grade);
                              }
                              registerProvider.setGrades(newGrades);
                            },
                            activeColor: Colors.amberAccent,
                            controlAffinity: ListTileControlAffinity.trailing,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(width: 1),
                            ),
                            checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Text(
                              grade[0].toUpperCase() + grade.substring(1),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.registerStep1Route,
                          );
                        },
                        child: const Text('Atrás'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.registerStep3Route,
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
