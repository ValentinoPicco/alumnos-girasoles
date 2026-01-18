import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/controllers/teach_controller.dart';
import 'package:alumnos_girasoles/widgets/button_card.dart';

class GradeScreen extends StatefulWidget {
  final int dni;
  final String gradeName;

  const GradeScreen({super.key, required this.dni, required this.gradeName});
  static const String routeName = '/grade';

  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
  late TeachController teachController;
  late Future<Set<String>> _futureSubjects;

  @override
  void initState() {
    super.initState();
    teachController = TeachController();
    _futureSubjects = teachController.obtainSubjectsByGrade(
      widget.dni,
      widget.gradeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 5, 72, 90),
            Color.fromARGB(255, 9, 70, 87), // Verde azulado oscuro
            Color.fromARGB(255, 56, 143, 170),
          ],
        ),
      ),
      child: Scaffold(),
    );
  }
}
