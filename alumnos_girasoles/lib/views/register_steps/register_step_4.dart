import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';

class RegisterStep4 extends StatelessWidget {
  final List<String> gradesToBeResponsible;
  final String? responsibleGrade;
  final ValueChanged<String?> onGradeChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const RegisterStep4({
    super.key,
    required this.gradesToBeResponsible,
    required this.responsibleGrade,
    required this.onGradeChanged,
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
                    for (var i = 0; i < gradesToBeResponsible.length; i++) ...[
                      RadioListTile<String>(
                        title: Text(
                          gradesToBeResponsible[i][0].toUpperCase() +
                              gradesToBeResponsible[i].substring(1),
                        ),
                        value: gradesToBeResponsible[i],
                        groupValue: responsibleGrade,
                        activeColor: Colors.amberAccent,
                        controlAffinity: ListTileControlAffinity.trailing,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(width: 1),
                        ),
                        onChanged: onGradeChanged,
                      ),
                      if (i < gradesToBeResponsible.length - 1)
                        const SizedBox(height: 8),
                    ],
                    const SizedBox(height: 30),
                  ],
                ),
              ),
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
