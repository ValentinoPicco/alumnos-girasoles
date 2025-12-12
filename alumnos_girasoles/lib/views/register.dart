import 'package:alumnos_girasoles/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_0.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_1.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_2.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_3.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_4.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_5.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = '/';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int step = 0;
  String selectedLevel = '';
  bool isResponsibleTeacher = false;
  Set<String> selectedGrades = {};
  String? responsibleGrade;
  Set<String> selectedSubjects = {};
  Set<String> subjectsToShow = {
    'lenguaYLiteratura',
    'matematica',
    'cienciasNaturales',
    'cienciasSociales',
    'ciudadaniaYParticipacion',
    'identidadYConvivencia',
    'musica',
    'arte',
    'educacionFisica',
    'ingles',
    'ecologia',
    'culturaDigital',
    'tecnologia',
  };

  final List<String> orderedGrades = [
    'primero',
    'segundo',
    'tercero',
    'cuarto',
    'quinto',
    'sexto',
  ];

  final TextEditingController dniController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RegisterController registerControler = RegisterController();

  @override
  void dispose() {
    dniController.dispose();
    nombreController.dispose();
    apellidoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget buildStepContent() {
    switch (step) {
      case 0:
        return RegisterStep0(
          dniController: dniController,
          nombreController: nombreController,
          apellidoController: apellidoController,
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
          registerControler: registerControler,
          onNext: () => setState(() => step = 1),
          context: context,
        );
      case 1:
        return RegisterStep1(
          selectedLevel: selectedLevel,
          onLevelChanged: (level) => setState(() => selectedLevel = level),
          onNext: () => setState(() => step = 2),
          onBack: () => setState(() => step = 0),
        );
      case 2:
        return RegisterStep2(
          selectedLevel: selectedLevel,
          selectedGrades: selectedGrades,
          orderedGrades: orderedGrades,
          onGradesChanged: (grades) => setState(() => selectedGrades = grades),
          onNext: () => setState(() => step = 3),
          onBack: () => setState(() => step = 1),
        );
      case 3:
        return RegisterStep3(
          onYes: () {
            setState(() {
              step = 4;
              isResponsibleTeacher = true;
            });
          },
          onNo: () => setState(() => step = 5),
          onBack: () => setState(() => step = 2),
        );
      case 4:
        final List<String> gradesToBeResponsible = orderedGrades
            .where((grade) => selectedGrades.contains(grade))
            .toList();
        return RegisterStep4(
          gradesToBeResponsible: gradesToBeResponsible,
          responsibleGrade: responsibleGrade,
          onGradeChanged: (grade) => setState(() => responsibleGrade = grade),
          onNext: () => setState(() => step = 5),
          onBack: () => setState(() => step = 3),
        );
      case 5:
        return RegisterStep5(
          subjectsToShow: subjectsToShow,
          selectedSubjects: selectedSubjects,
          onSubjectsChanged: (subjects) =>
              setState(() => selectedSubjects = subjects),
          onNext: () => registerControler.registerAccount(
            dniController.text.trim(),
            nombreController.text,
            apellidoController.text,
            emailController.text.trim(),
            passwordController.text.trim(),
            responsibleGrade,
            selectedLevel,
            selectedSubjects,
            selectedGrades,
          ),
          onBack: () => setState(() => step = 4),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creando tu cuenta'),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(child: buildStepContent()),
    );
  }
}
