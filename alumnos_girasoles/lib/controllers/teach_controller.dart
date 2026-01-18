import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeachController {
  final supabase = Supabase.instance.client;

  TeachController();

  Future<Set<String>> obtainGradesNamesTaught(int dni) async {
    try {
      final List<Map<String, dynamic>> response = await supabase
          .from('teaches')
          .select('grade_name')
          .eq('teacher_dni', dni);

      final Set<String> gradesEarneds = response
          .map((fila) => fila['grade_name'] as String)
          .toSet();

      return gradesEarneds;
    } catch (e) {
      debugPrint('Error al obtener los grados: $e');
      return <String>{};
    }
  }

  Future<Set<String>> obtainSubjectsByGrade(int dni, String gradeName) async {
    try {
      final List<Map<String, dynamic>> response = await supabase
          .from('teaches')
          .select('subject_name')
          .eq('teacher_dni', dni)
          .eq('grade_name', gradeName);

      final Set<String> subjectEarneds = response
          .map((fila) => fila['subject_name'] as String)
          .toSet();

      return subjectEarneds;
    } catch (e) {
      debugPrint('Error al obtener las materias de $gradeName grado: $e');
      return <String>{};
    }
  }
}
