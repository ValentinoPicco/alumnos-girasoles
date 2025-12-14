import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';
import 'package:alumnos_girasoles/routes/app_router.dart';
import 'package:google_fonts/google_fonts.dart';

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

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 9, 70, 87), // Verde azulado oscuro
                  Color.fromARGB(255, 56, 143, 170),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        color: Colors.amberAccent,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.yellow,
                                Colors.amberAccent,
                                Colors.amber,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: SizedBox(
                            width: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 25.0),
                                Text(
                                  '¿En qué grados das clases?',
                                  style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    children: gradesToShow.map((grade) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // definimos el borde y el radio
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                255,
                                                9,
                                                70,
                                                87,
                                              ),
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: CheckboxListTile(
                                            value: registerProvider
                                                .selectedGrades
                                                .contains(grade),
                                            onChanged: (bool? checked) {
                                              final newGrades =
                                                  Set<String>.from(
                                                    registerProvider
                                                        .selectedGrades,
                                                  );
                                              if (checked == true) {
                                                newGrades.add(grade);
                                              } else {
                                                newGrades.remove(grade);
                                              }
                                              registerProvider.setGrades(
                                                newGrades,
                                              );
                                            },
                                            activeColor: Color.fromARGB(
                                              255,
                                              56,
                                              143,
                                              170,
                                            ),
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                            checkboxShape:
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                            title: Text(
                                              grade[0].toUpperCase() +
                                                  grade.substring(1),
                                            ),
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
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                      ),
                                      child: const Text(
                                        'Atrás',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRouter.registerStep3Route,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                      ),
                                      child: const Text(
                                        'Siguiente',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                doYouHaveAnAccount(context),
                const SizedBox(height: 3),
              ],
            ),
          ),
        );
      },
    );
  }
}
