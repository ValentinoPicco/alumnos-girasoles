import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';

class RegisterStep2 extends StatelessWidget {
  final String selectedLevel;
  final Set<String> selectedGrades;
  final List<String> orderedGrades;
  final ValueChanged<Set<String>> onGradesChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const RegisterStep2({
    super.key,
    required this.selectedLevel,
    required this.selectedGrades,
    required this.orderedGrades,
    required this.onGradesChanged,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    // Filtramos grados según el ciclo
    List<String> gradesToShow;
    if (selectedLevel == 'lower') {
      gradesToShow = orderedGrades.sublist(0, 3);
    } else if (selectedLevel == 'upper') {
      gradesToShow = orderedGrades.sublist(3, 6);
    } else {
      gradesToShow = orderedGrades;
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
                        value: selectedGrades.contains(grade),
                        onChanged: (bool? checked) {
                          final newGrades = Set<String>.from(selectedGrades);
                          if (checked == true) {
                            newGrades.add(grade);
                          } else {
                            newGrades.remove(grade);
                          }
                          onGradesChanged(newGrades);
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
        doYouHaveAnAccount(),
        const SizedBox(height: 3),
      ],
    );
  }
}
