enum Level { lower, upper, both }

extension LevelExtension on Level {
  String get name {
    switch (this) {
      case Level.lower:
        return 'Primer Ciclo';
      case Level.upper:
        return 'Segundo Ciclo';
      case Level.both:
        return 'Ambos';
    }
  }
}

enum Grade { primero, segundo, tercero, cuarto, quinto, sexto }

enum Subject {
  lenguaYLiteratura,
  matematica,
  cienciasNaturales,
  cienciasSociales,
  ciudadaniaYParticipacion,
  identidadYConvivencia,
  musica,
  arte,
  educacionFisica,
  ingles,
  ecologia,
  culturaDigital,
  tecnologia,
}

extension SubjectExtension on Subject {
  String get name {
    switch (this) {
      case Subject.lenguaYLiteratura:
        return 'Lengua y Literatura';
      case Subject.matematica:
        return 'Matemática';
      case Subject.cienciasNaturales:
        return 'Ciencias Naturales';
      case Subject.cienciasSociales:
        return 'Ciencias Sociales';
      case Subject.ciudadaniaYParticipacion:
        return 'Ciudadanía y Participación';
      case Subject.identidadYConvivencia:
        return 'Identidad y Convivencia';
      case Subject.musica:
        return 'Música';
      case Subject.arte:
        return 'Arte';
      case Subject.educacionFisica:
        return 'Educación Física';
      case Subject.ingles:
        return 'Inglés';
      case Subject.ecologia:
        return 'Ecología';
      case Subject.culturaDigital:
        return 'Cultura Digital';
      case Subject.tecnologia:
        return 'Tecnología';
    }
  }
}

enum Role { padre, madre, tutor }
