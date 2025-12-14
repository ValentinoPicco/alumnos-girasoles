import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/widgets/custom_radio_buttons.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';
import 'package:alumnos_girasoles/routes/app_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterStep1 extends StatelessWidget {
  const RegisterStep1({super.key});

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
                            width: 350,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 25.0),
                                Text(
                                  '¿En qué ciclo das clases?',
                                  style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 25),
                                CustomRadioButtons(
                                  options: [
                                    "Primer Ciclo",
                                    "Segundo Ciclo",
                                    "Ambos",
                                  ],
                                  onChanged: (value) {
                                    switch (value) {
                                      case 0:
                                        registerProvider.setLevel('lower');
                                        break;
                                      case 1:
                                        registerProvider.setLevel('upper');
                                        break;
                                      case 2:
                                        registerProvider.setLevel('both');
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
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRouter.registerStep0Route,
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
                                          AppRouter.registerStep2Route,
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
                                SizedBox(height: 20.0),
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
