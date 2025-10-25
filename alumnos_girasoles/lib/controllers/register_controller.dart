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
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return false;
    }

    final dniResponse = await supabase
        .from('docentes')
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
        ),
      );
      return false;
    }

    final emailResponse = await supabase
        .from('docentes')
        .select()
        .eq('email', email)
        .maybeSingle();

    if (emailResponse != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ya existe un docente con ese email',
            textAlign: TextAlign.center,
          ),
        ),
      );
      return false;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingresa un correo válido')),
      );
      return false;
    }

    if (password.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La contraseña debe tener al menos 6 caracteres'),
        ),
      );
      return false;
    }

    if (password.trim() != confirmPassword.trim()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Las contraseñas no coinciden')));
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
