import 'package:alumnos_girasoles/routes/app_router.dart';
import 'package:alumnos_girasoles/views/register/register_entry.dart';
import 'package:alumnos_girasoles/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = LoginController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Builder(
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Alumnos Girasoles',
                              style: GoogleFonts.merriweather(
                                color: Color.fromARGB(255, 236, 236, 236),
                                fontSize: 40.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 80),
                            Card(
                              color: Colors.amberAccent,
                              elevation: 12,
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
                                  height: 365,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Iniciar Sesión',
                                        style: GoogleFonts.notoSans(
                                          color: Colors.black,
                                          fontSize: 34.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
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
                                      const SizedBox(height: 35),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.amber,
                                        ),
                                        onPressed: () async {
                                          if (await loginController
                                              .signInDocente(
                                                emailController.text,
                                                passwordController.text,
                                                context,
                                              )) {
                                            if (context.mounted) {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                AppRouter.homeRoute,
                                                arguments: loginController.dni,
                                              );
                                            }
                                          }
                                        },
                                        child: const Text(
                                          'Ingresar',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿Todavía no te registraste?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterEntry.routeName);
                        },
                        child: const Text(
                          'Hazlo Aquí',
                          style: TextStyle(color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
