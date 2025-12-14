import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/enums/enums.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';
import 'package:alumnos_girasoles/routes/app_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterStep5 extends StatelessWidget {
  const RegisterStep5({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, registerProvider, _) {
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
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 1000,
                            child: Card(
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

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 25.0),
                                    Text(
                                      'Selecciona las materias que dictas',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10.0),
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 10,
                                      runSpacing: 20,
                                      children: registerProvider.subjectsToShow.map(
                                        (subject) {
                                          final subj = Subject.values
                                              .firstWhere(
                                                (e) =>
                                                    e
                                                        .toString()
                                                        .split('.')
                                                        .last
                                                        .toLowerCase() ==
                                                    subject.toLowerCase(),
                                                orElse: () =>
                                                    Subject.lenguaYLiteratura,
                                              );
                                          return SizedBox(
                                            width: 300,
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
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white,
                                              ),
                                              child: CheckboxListTile(
                                                value: registerProvider
                                                    .selectedSubjects
                                                    .contains(subject),
                                                onChanged: (bool? checked) {
                                                  final newSubjects =
                                                      Set<String>.from(
                                                        registerProvider
                                                            .selectedSubjects,
                                                      );
                                                  checked!
                                                      ? newSubjects.add(subject)
                                                      : newSubjects.remove(
                                                          subject,
                                                        );
                                                  registerProvider.setSubjects(
                                                    newSubjects,
                                                  );
                                                },
                                                title: Text(subj.name),
                                                activeColor: Color.fromARGB(
                                                  255,
                                                  56,
                                                  143,
                                                  170,
                                                ),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .trailing,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  side: const BorderSide(
                                                    width: 1,
                                                  ),
                                                ),
                                                checkboxShape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15,
                                                          ),
                                                    ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              AppRouter.registerStep4Route,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber,
                                          ),
                                          child: const Text(
                                            'Atrás',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Aquí deberías integrar la lógica para completar el registro
                                            Navigator.pushNamed(
                                              context,
                                              AppRouter.homeRoute,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber,
                                          ),
                                          child: const Text(
                                            'Completar registro',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
