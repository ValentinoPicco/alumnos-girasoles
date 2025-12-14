import 'package:alumnos_girasoles/routes/app_router.dart';
import 'package:alumnos_girasoles/views/register/register_entry.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
                                          if (await signInDocente(
                                            emailController.text,
                                            passwordController.text,
                                          )) {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              AppRouter.homeRoute,
                                            );
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

  // pasar esto a un controller
  Future<bool> signInDocente(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        print('Ingresaste con éxito: ${response.user!.email}');
        return true;
      } else if (response.session == null) {
        print('Registro incompleto, falta confirmar el email');
      } else {
        print('Error: ${response}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }
}
