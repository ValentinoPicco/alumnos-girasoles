import 'package:alumnos_girasoles/controllers/register_controller.dart';
import 'package:alumnos_girasoles/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:alumnos_girasoles/widgets/custom_text_field.dart';
import 'package:alumnos_girasoles/widgets/custom_radio_buttons.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = '/';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int step = 1;
  String selectedLevel = '';
  bool isResponsibleTeacher = false;
  Set<String> selectedGrades = {};
  String? responsibleGrade;
  Set<String> selectedSubjects = {};

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
    nombreController.dispose();
    apellidoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget buildStepContent() {
    switch (step) {
      case 0: // Primer paso para registrarse
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Completa tus datos',
                    style: TextStyle(fontSize: 28.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(labelText: 'DNI', controller: dniController),
                  const SizedBox(height: 8),
                  CustomTextField(
                    labelText: 'Nombre',
                    controller: nombreController,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    labelText: 'Apellido',
                    controller: apellidoController,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    labelText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    labelText: 'Contraseña',
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    labelText: 'Confirmar Contraseña',
                    obscureText: true,
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (await registerControler.validarDatos(
                        dniController.text,
                        nombreController.text,
                        apellidoController.text,
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                        context,
                      )) {
                        setState(() => step = 1);
                      }
                    },
                    child: Text('Siguiente'),
                  ),
                ],
              ),
            ),
            doYouHaveAnAccount(),
            const SizedBox(height: 3),
          ],
        );
      case 1: // Segundo paso
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
                          selectedLevel = 'lower';
                          break;
                        case 1:
                          selectedLevel = 'upper';
                          break;

                        case 2:
                          selectedLevel = 'both';
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
                        onPressed: () => setState(() => step = 0),
                        child: Text('Atrás'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => step = 2);
                          debugPrint(selectedLevel);
                        },
                        child: Text('Siguiente'),
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
      case 2: // Tercer paso
        // Filtramos grados según el ciclo
        List<String> gradesToShow;
        if (selectedLevel == 'lower') {
          gradesToShow = orderedGrades.sublist(
            0,
            3,
          ); // primero, segundo, tercero
        } else if (selectedLevel == 'upper') {
          gradesToShow = orderedGrades.sublist(3, 6); // cuarto, quinto, sexto
        } else {
          gradesToShow = orderedGrades; // ambos ciclos
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
                      children: gradesToShow.map((grado) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: CheckboxListTile(
                            value: selectedGrades.contains(grado),
                            onChanged: (bool? checked) {
                              setState(() {
                                if (checked == true) {
                                  selectedGrades.add(grado);
                                } else {
                                  selectedGrades.remove(grado);
                                }
                              });
                            },
                            activeColor: Colors.amberAccent,
                            controlAffinity: ListTileControlAffinity.trailing,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(width: 1),
                            ),
                            checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Text(
                              grado[0].toUpperCase() + grado.substring(1),
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
                        onPressed: () => setState(() => step = 1),
                        child: Text('Atrás'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => step = 3);
                          debugPrint(selectedGrades.toString());
                        },
                        child: Text('Siguiente'),
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
      case 3: // Cuarto paso
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
                          setState(() => step = 4);
                          isResponsibleTeacher = true;
                        },
                        child: Text('Si'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => step = 5);
                        },
                        child: Text('No'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => setState(() => step = 2),
                    child: Text('Atrás'),
                  ),
                ],
              ),
            ),
            doYouHaveAnAccount(),
            const SizedBox(height: 3),
          ],
        );
      case 4: // Quinto paso
        final List<String> gradesToBeResponsible = orderedGrades
            .where((grado) => selectedGrades.contains(grado))
            .toList();
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "¿De que grado eres responsable?",
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
                          i < gradesToBeResponsible.length;
                          i++
                        ) ...[
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
                              side: BorderSide(width: 1),
                            ),
                            onChanged: (value) {
                              setState(() {
                                responsibleGrade = value;
                              });
                            },
                          ),
                          if (i < gradesToBeResponsible.length - 1)
                            SizedBox(height: 8),
                        ],
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => setState(() => step = 3),
                        child: Text('Atrás'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => step = 5);
                          debugPrint(selectedGrades.toString());
                        },
                        child: Text('Siguiente'),
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

      case 5: // Quinto paso seleccionar materias
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Selecciona las materias que dictas en',
                    style: TextStyle(fontSize: 28.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(width: 200, child: Column()),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => setState(() => step = 4),
                        child: Text('Atrás'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // setState(() => step = 5);
                          registerControler.registerAccount(
                            dniController.text.trim(),
                            nombreController.text,
                            apellidoController.text,
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            responsibleGrade,
                            selectedLevel,
                            selectedSubjects,
                            selectedGrades,
                          );
                        },
                        child: Text('Completar registro'),
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
