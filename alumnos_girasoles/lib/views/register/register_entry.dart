import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumnos_girasoles/views/register_steps/register_step_0.dart';
import 'package:alumnos_girasoles/providers/register_provider.dart';

class RegisterEntry extends StatelessWidget {
  const RegisterEntry({super.key});
  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterProvider>(
        builder: (context, registerProvider, _) {
          return const RegisterStep0();
        },
      ),
    );
  }
}
