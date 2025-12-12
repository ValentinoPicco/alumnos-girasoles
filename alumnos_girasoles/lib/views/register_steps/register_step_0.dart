import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/widgets/custom_text_field.dart';
import 'package:alumnos_girasoles/widgets/do_you_have_an_account.dart';
import 'package:alumnos_girasoles/controllers/register_controller.dart';

class RegisterStep0 extends StatelessWidget {
  final TextEditingController dniController;
  final TextEditingController nombreController;
  final TextEditingController apellidoController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final RegisterController registerControler;
  final VoidCallback onNext;
  final BuildContext context;

  const RegisterStep0({
    super.key,
    required this.dniController,
    required this.nombreController,
    required this.apellidoController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.registerControler,
    required this.onNext,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
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
              CustomTextField(labelText: 'Email', controller: emailController),
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
                    onNext();
                  }
                },
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ),
        doYouHaveAnAccount(),
        const SizedBox(height: 3),
      ],
    );
  }
}
