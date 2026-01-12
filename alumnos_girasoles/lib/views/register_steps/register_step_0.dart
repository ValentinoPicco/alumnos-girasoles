import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/widgets/custom_text_field.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/controllers/register_controller.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';
import 'package:alumnos_girasoles/routes/app_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterStep0 extends StatefulWidget {
  const RegisterStep0({super.key});

  @override
  State<RegisterStep0> createState() => _RegisterStep0State();
}

class _RegisterStep0State extends State<RegisterStep0> {
  late TextEditingController dniController;
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late RegisterController registerController;

  @override
  void initState() {
    super.initState();
    dniController = TextEditingController();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    registerController = RegisterController();
  }

  @override
  void dispose() {
    dniController.dispose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
                                  children: [
                                    const SizedBox(height: 15),
                                    Text(
                                      'Completa tus datos',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 15),
                                    CustomTextField(
                                      labelText: 'DNI',
                                      controller: dniController,
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      labelText: 'Nombre',
                                      controller: nameController,
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      labelText: 'Apellido',
                                      controller: surnameController,
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
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                      ),
                                      onPressed: () async {
                                        if (await registerController
                                            .validarDatos(
                                              dniController.text,
                                              nameController.text,
                                              surnameController.text,
                                              emailController.text,
                                              passwordController.text,
                                              confirmPasswordController.text,
                                              context,
                                            )) {
                                          registerProvider.setPersonalData(
                                            dni: dniController.text,
                                            name: nameController.text,
                                            surname: surnameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                          if (context.mounted) {
                                            Navigator.pushNamed(
                                              context,
                                              AppRouter.registerStep1Route,
                                            );
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'Siguiente',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
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
