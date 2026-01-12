import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';
import 'package:alumnos_girasoles/routes/app_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterStep4 extends StatelessWidget {
  const RegisterStep4({super.key});

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                const Color.fromARGB(255, 255, 234, 49),
                                const Color.fromARGB(255, 255, 209, 43),
                                Colors.amber,
                                const Color.fromARGB(255, 255, 153, 0),
                                const Color.fromARGB(255, 255, 145, 0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: SizedBox(
                            width: 350,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20.0),
                                Text(
                                  "¿De que grado eres responsable?",
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
                                    children: [
                                      for (
                                        var i = 0;
                                        i <
                                            registerProvider
                                                .selectedGrades
                                                .length;
                                        i++
                                      ) ...[
                                        Container(
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
                                          child: RadioListTile<String>(
                                            title: Text(
                                              registerProvider.selectedGrades
                                                      .toList()[i][0]
                                                      .toUpperCase() +
                                                  registerProvider
                                                      .selectedGrades
                                                      .toList()[i]
                                                      .substring(1),
                                            ),
                                            value: registerProvider
                                                .selectedGrades
                                                .toList()[i],
                                            groupValue: registerProvider
                                                .responsibleGrade,
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
                                              side: const BorderSide(width: 1),
                                            ),
                                            onChanged: (value) {
                                              registerProvider
                                                  .setResponsibleGrade(value);
                                            },
                                          ),
                                        ),
                                        if (i <
                                            registerProvider
                                                    .selectedGrades
                                                    .length -
                                                1)
                                          const SizedBox(height: 8),
                                      ],
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                        'Atrás',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRouter.registerStep5Route,
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
                                SizedBox(height: 25.0),
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
