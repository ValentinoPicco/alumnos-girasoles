import 'package:alumnos_girasoles/models/teacher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeacherController {
  final supabase = Supabase.instance.client;

  Future<bool> existsDni(int dni) async {
    final result = await supabase
        .from('teachers')
        .select()
        .eq('dni', dni)
        .maybeSingle();
    return result != null;
  }

  Future<bool> addTeacher(Teacher teacher) async {
    try {
      await supabase.from('teachers').insert(teacher.toMap());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<List<Teacher>> getAllTeachers() async {
    final result = await supabase.from('teachers').select();
    return (result as List).map((row) => Teacher.fromMap(row)).toList();
  }
}
