import 'package:alumnos_girasoles/widgets/beauty_snackbar.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController {
  int? _dni;

  int? get dni => _dni;

  Future<bool> signInDocente(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Obtener el DNI del usuario de la tabla teachers usando el auth_id
        final teacher = await Supabase.instance.client
            .from('teachers')
            .select()
            .eq('auth_id', response.user!.id)
            .maybeSingle();

        if (teacher != null && teacher['dni'] != null) {
          _dni = teacher['dni'] as int?;
        }
        return true;
      } else if (response.session == null) {
        if (context.mounted) {
          BeautySnackbar.show(
            context,
            'Registro incompleto, falta confirmar el email',
          );
        }
      } else {
        if (context.mounted) {
          BeautySnackbar.show(context, 'Error: $response');
        }
      }
    } catch (e) {
      String errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo.';

      // Errores específicos de Supabase (Contraseña mal, usuario no existe, etc)
      if (e is AuthException) {
        errorMessage = _translateError(e.message);
      }
      // Errores de conexión (Sin internet)
      else if (e is SocketException) {
        errorMessage = 'No hay conexión a internet. Revisa tu red.';
      }
      // Otros errores
      else {
        debugPrint('Error desconocido: $e');
      }

      if (context.mounted) {
        BeautySnackbar.show(context, errorMessage);
      }
    }
    return false;
  }

  String _translateError(String origialMessage) {
    if (origialMessage.contains('Invalid login credentials')) {
      return 'Email o contraseña incorrectos.';
    }
    if (origialMessage.contains('Email not confirmed')) {
      return 'Tu email no ha sido confirmado. Revisa tu correo.';
    }
    // Si no coincide con ninguno conocido, mostramos el original o uno genérico
    return origialMessage;
  }
}
