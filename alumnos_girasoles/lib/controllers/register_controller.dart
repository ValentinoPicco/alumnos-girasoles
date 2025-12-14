import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/models/teacher.dart';
import 'package:alumnos_girasoles/models/teach.dart';
import 'package:alumnos_girasoles/enums/enums.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Por favor, completa todos los campos',
            textAlign: TextAlign.center,
          ),
          elevation: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15.0),
          ),
        ),
      );
      return false;
    }

    final dniResponse = await supabase
        .from('teachers')
        .select()
        .eq('dni', dni)
        .maybeSingle();

    if (dniResponse != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ya existe un docente con ese DNI',
            textAlign: TextAlign.center,
          ),
          elevation: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15.0),
          ),
        ),
      );
      return false;
    }

    final bool emailResponse = await supabase.rpc(
      'check_email_exists',
      params: {'email_input': email},
    );

    if (emailResponse) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ya existe un docente con ese email',
            textAlign: TextAlign.center,
          ),
          elevation: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15.0),
          ),
        ),
      );
      return false;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Por favor, ingresa un correo válido',
            textAlign: TextAlign.center,
          ),
          elevation: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15.0),
          ),
        ),
      );
      return false;
    }

    if (password.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'La contraseña debe tener al menos 6 caracteres',
            textAlign: TextAlign.center,
          ),
          elevation: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15.0),
          ),
        ),
      );
      return false;
    }

    if (password.trim() != confirmPassword.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Las contraseñas no coinciden',
            textAlign: TextAlign.center,
          ),
          elevation: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15.0),
          ),
        ),
      );
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
  ) async {
    email = email.trim();
    password = password.trim();
    AuthResponse? response;

    try {
      response = await supabase.auth.signUp(email: email, password: password);
    } catch (e) {
      debugPrint('error al registrar user: $e');
    }

    final user = response!.user;
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
          debugPrint('Insert Teach OK: $insert');
        } catch (e) {
          debugPrint('Error al insertar: $e');
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
          debugPrint('Insert Teach OK: $insert');
        } catch (e) {
          debugPrint('Error al insertar: $e');
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
          debugPrint('Insert Teach OK: $insert');
        } catch (e) {
          debugPrint('Error al insertar: $e');
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
        );
        try {
          final insert = await supabase
              .from('teaches')
              .insert(teach.toMap())
              .select();
          debugPrint('Insert Teach OK: $insert');
        } catch (e) {
          debugPrint('Error al insertar: $e');
          return false;
        }
      }
    }
    return true;
  }
}
