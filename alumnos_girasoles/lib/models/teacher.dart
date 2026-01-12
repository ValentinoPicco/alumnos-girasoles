import 'package:alumnos_girasoles/enums/enums.dart';

class Teacher {
  final int dni;
  final String surname;
  final String name;
  final Grade? gradeHolder;
  final String authId;

  Teacher({
    required this.dni,
    required this.surname,
    required this.name,
    this.gradeHolder,
    required this.authId,
  });

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      dni: map['dni'],
      surname: map['surname'],
      name: map['name'],
      gradeHolder: map['grade_holder'] != null
          ? Grade.values.firstWhere((e) => e.name == map['grade_holder'])
          : null,
      authId: map['auth_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dni': dni,
      'surname': surname,
      'name': name,
      'grade_holder': gradeHolder?.name,
      'auth_id': authId,
    };
  }
}
