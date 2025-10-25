import 'package:alumnos_girasoles/enums/enums.dart';

class Teach {
  int teacherDni;
  Subject subjectName;
  Grade gradeName;

  Teach({
    required this.teacherDni,
    required this.subjectName,
    required this.gradeName,
  });

  void setDni(int dni) {
    teacherDni = dni;
  }

  void setSubject(Subject subject) {
    subjectName = subject;
  }

  void setGrade(Grade grade) {
    gradeName = grade;
  }

  factory Teach.fromMap(Map<String, dynamic> map) {
    return Teach(
      teacherDni: map['teacher_dni'],
      subjectName: map['subject_name'],
      gradeName: map['grade_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teacher_dni': teacherDni,
      'subject_name': subjectName,
      'grade_name': gradeName,
    };
  }
}
