import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeachController {
  int? dni;
  final supabase = Supabase.instance.client;

  TeachController(this.dni);

  Future<Set<String>> obtainGradesNamesTaught() async {
    try {
      final List<Map<String, dynamic>> response = await supabase
          .from('teaches')
          .select('grade_name')
          .eq('teacher_dni', dni!);

      final Set<String> gradesEarneds = response
          .map((fila) => fila['grade_name'] as String)
          .toSet();

      return gradesEarneds;
    } catch (e) {
      debugPrint('Error al obtener los grados: $e');
      return <String>{};
    }
  }
}
