import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/models/teacher.dart';
import 'package:alumnos_girasoles/models/teach.dart';
import 'package:alumnos_girasoles/enums/enums.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:alumnos_girasoles/widgets/beauty_snackbar.dart';

class RegisterController {
  final supabase = Supabase.instance.client;

  Future<bool> validarDatos(
    String dni,
    String name,
    String surname,
    String email,
    String password,
    String confirmPassword,
    BuildContext context,
  ) async {
    if (dni.isEmpty ||
        name.isEmpty ||
        surname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      BeautySnackbar.show(context, 'Por favor, completa todos los campos');
      return false;
    }

    final dniResponse = await supabase
        .from('teachers')
        .select()
        .eq('dni', dni)
        .maybeSingle();

    if (dniResponse != null) {
      if (context.mounted) {
        BeautySnackbar.show(context, 'Ya existe un docente con ese DNI');
      }
      return false;
    }

    final bool emailResponse = await supabase.rpc(
      'check_email_exists',
      params: {'email_input': email},
    );

    if (emailResponse) {
      if (context.mounted) {
        BeautySnackbar.show(context, 'Ya existe un docente con ese email');
      }
      return false;
    }

    if (!email.contains('@') || !email.contains('.com')) {
      if (context.mounted) {
        BeautySnackbar.show(context, 'Por favor, ingresa un email válido');
      }
      return false;
    }

    if (password.trim().length < 6) {
      if (context.mounted) {
        BeautySnackbar.show(
          context,
          'La contraseña debe tener al menos 6 caracteres',
        );
      }

      return false;
    }

    if (password.trim() != confirmPassword.trim()) {
      if (context.mounted) {
        BeautySnackbar.show(context, 'Las contraseñas no coinciden');
      }
      return false;
    }

    return true;
  }

  Future<bool> registerAccount(
    String dniStr,
    String name,
    String surname,
    String email,
    String password,
    String? gradeHolder,
    String selectedLevel,
    Set<String> subjects,
    Set<String> grades,
    BuildContext context,
  ) async {
    email = email.trim();
    password = password.trim();
    AuthResponse? response;

    try {
      response = await supabase.auth.signUp(email: email, password: password);
    } catch (e) {
      if (context.mounted) {
        BeautySnackbar.show(context, 'Ocurrió un error al registrarte \n $e');
      }
      return false;
    }

    final user = response.user;
    final dni = int.parse(dniStr);

    return await insertTeacher(
          dni,
          name,
          surname,
          email,
          password,
          gradeHolder,
          user,
        ) &&
        await insertTeach(dni, selectedLevel, subjects, grades, gradeHolder);
  }

  Future<bool> insertTeacher(
    int dni,
    String name,
    String surname,
    String email,
    String password,
    String? gradeHolder,
    User? user,
  ) async {
    if (gradeHolder != null) {
      Teacher newTeacher = Teacher(
        dni: dni,
        surname: surname,
        name: name,
        authId: user!.id,
        gradeHolder: Grade.values.firstWhere((e) => e.name == gradeHolder),
      );

      try {
        final insert = await supabase
            .from('teachers')
            .insert(newTeacher.toMap())
            .select(); // para que devuelva la fila insertada

        debugPrint('Insert Teacher OK: $insert');
        return true;
      } catch (e) {
        debugPrint('Error al insertar: $e');
        return false;
      }
    } else {
      Teacher newTeacher = Teacher(
        dni: dni,
        surname: surname,
        name: name,
        authId: user!.id,
      );

      try {
        final insert = await supabase
            .from('teachers')
            .insert(newTeacher.toMap())
            .select(); // para que devuelva la fila insertada

        debugPrint('Insert Teacher OK: $insert');
        return true;
      } catch (e) {
        debugPrint('Error al insertar: $e');
        return false;
      }
    }
  }

  // basado en la logica de negocio
  Future<bool> insertTeach(
    int dni,
    String selectedLevel,
    Set<String> subjects,
    Set<String> grades,
    String? gradeHolder,
  ) async {
    Teach teach;
    Set<String> subjectsResp;
    if (gradeHolder == null) {
      for (String grade in grades) {
        teach = Teach(
          teacherDni: dni,
          subjectName: Subject.values.firstWhere(
            (s) => s.toString().split('.').last == subjects.first,
          ),
          gradeName: Grade.values.firstWhere(
            (g) => g.toString().split('.').last == grade,
          ),
        );
        try {
          final insert = await supabase
              .from('teaches')
              .insert(teach.toMap())
              .select();
          debugPrint('Insert Teach Case 1 OK: $insert');
          return true;
        } catch (e) {
          debugPrint('Insert Teach Case 1 ERROR: $e');
          return false;
        }
      }
    } else if (selectedLevel == 'lower') {
      for (String subject in subjects) {
        teach = Teach(
          teacherDni: dni,
          subjectName: Subject.values.firstWhere(
            (s) => s.toString().split('.').last == subject,
          ),
          gradeName: Grade.values.firstWhere(
            (g) => g.toString().split('.').last == gradeHolder,
          ),
        );
        try {
          final insert = await supabase
              .from('teaches')
              .insert(teach.toMap())
              .select();
          debugPrint('IInsert Teach Case 2 OK: $insert');
          return true;
        } catch (e) {
          debugPrint('Insert Teach Case 2 ERROR: $e');
          return false;
        }
      }
    } else if (selectedLevel == 'upper') {
      for (String grade in grades) {
        teach = Teach(
          teacherDni: dni,
          subjectName: Subject.values.firstWhere(
            (s) => s.toString().split('.').last == subjects.first,
          ),
          gradeName: Grade.values.firstWhere(
            (g) => g.toString().split('.').last == grade,
          ),
        );
        try {
          final insert = await supabase
              .from('teaches')
              .insert(teach.toMap())
              .select();
          debugPrint('Insert Teach Case 3 OK: $insert');
        } catch (e) {
          debugPrint('Insert Teach Case 3 ERROR: $e');
          return false;
        }
      }
      subjectsResp = {'ciudadaniaYParticipacion', 'tecnologia'};
      for (String subject in subjectsResp) {
        teach = Teach(
          teacherDni: dni,
          subjectName: Subject.values.firstWhere(
            (s) => s.toString().split('.').last == subject,
          ),
          gradeName: Grade.values.firstWhere(
            (g) => g.toString().split('.').last == gradeHolder,
          ),
        ); // ver los return de por aca y antes
        try {
          final insert = await supabase
              .from('teaches')
              .insert(teach.toMap())
              .select();
          debugPrint('Insert Teach Case 4 OK: $insert');
          return true;
        } catch (e) {
          debugPrint('Insert Teach Case 4 ERROR: $e');
          return false;
        }
      }
    }
    debugPrint('Insert Teach Case 5 ERROR: No entro en ninguna condicion');
    return false;
  }
}
