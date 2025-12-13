import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/enums/enums.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';
import 'package:alumnos_girasoles/routes/app_router.dart';

class RegisterStep5 extends StatelessWidget {
  const RegisterStep5({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, registerProvider, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Selecciona las materias que dictas',
              style: TextStyle(fontSize: 28.0),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: SizedBox(
                width: 1000,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 20,
                  children: registerProvider.subjectsToShow.map((subject) {
                    final subj = Subject.values.firstWhere(
                      (e) =>
                          e.toString().split('.').last.toLowerCase() ==
                          subject.toLowerCase(),
                      orElse: () => Subject.lenguaYLiteratura,
                    );

                    return SizedBox(
                      width: 300,
                      child: CheckboxListTile(
                        value: registerProvider.selectedSubjects.contains(
                          subject,
                        ),
                        onChanged: (bool? checked) {
                          final newSubjects = Set<String>.from(
                            registerProvider.selectedSubjects,
                          );
                          checked!
                              ? newSubjects.add(subject)
                              : newSubjects.remove(subject);
                          registerProvider.setSubjects(newSubjects);
                        },
                        title: Text(subj.name),
                        activeColor: Colors.amberAccent,
                        controlAffinity: ListTileControlAffinity.trailing,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(width: 1),
                        ),
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.registerStep4Route);
                  },
                  child: const Text('Atrás'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Aquí deberías integrar la lógica para completar el registro
                    Navigator.pushNamed(context, AppRouter.homeRoute);
                  },
                  child: const Text('Completar registro'),
                ),
              ],
            ),
            doYouHaveAnAccount(context),
            const SizedBox(height: 3),
          ],
        );
      },
    );
  }
}
