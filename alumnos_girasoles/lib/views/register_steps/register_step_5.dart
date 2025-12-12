import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/enums/enums.dart';

class RegisterStep5 extends StatelessWidget {
  final Set<String> subjectsToShow;
  final Set<String> selectedSubjects;
  final ValueChanged<Set<String>> onSubjectsChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const RegisterStep5({
    super.key,
    required this.subjectsToShow,
    required this.selectedSubjects,
    required this.onSubjectsChanged,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
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
              children: subjectsToShow.map((subject) {
                final subj = Subject.values.firstWhere(
                  (e) =>
                      e.toString().split('.').last.toLowerCase() ==
                      subject.toLowerCase(),
                  orElse: () => Subject.lenguaYLiteratura,
                );

                return SizedBox(
                  width: 300,
                  child: CheckboxListTile(
                    value: selectedSubjects.contains(subject),
                    onChanged: (bool? checked) {
                      final newSubjects = Set<String>.from(selectedSubjects);
                      checked!
                          ? newSubjects.add(subject)
                          : newSubjects.remove(subject);
                      onSubjectsChanged(newSubjects);
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
            ElevatedButton(onPressed: onBack, child: const Text('Atrás')),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: onNext,
              child: const Text('Completar registro'),
            ),
          ],
        ),
        doYouHaveAnAccount(context),
        const SizedBox(height: 3),
      ],
    );
  }
}
