import 'package:flutter/foundation.dart';

class RegisterProvider extends ChangeNotifier {
  int step = 0;
  String selectedLevel = '';
  Set<String> selectedGrades = {};
  String? responsibleGrade;
  Set<String> selectedSubjects = {};
  bool isResponsibleTeacher = false;

  // Datos personales
  String dni = '';
  String nombre = '';
  String apellido = '';
  String email = '';
  String password = '';

  final List<String> orderedGrades = [
    'primero',
    'segundo',
    'tercero',
    'cuarto',
    'quinto',
    'sexto',
  ];

  final Set<String> subjectsToShow = {
    'lenguaYLiteratura',
    'matematica',
    'cienciasNaturales',
    'cienciasSociales',
    'ciudadaniaYParticipacion',
    'identidadYConvivencia',
    'musica',
    'arte',
    'educacionFisica',
    'ingles',
    'ecologia',
    'culturaDigital',
    'tecnologia',
  };

  void nextStep() {
    step++;
    notifyListeners();
  }

  void previousStep() {
    if (step > 0) {
      step--;
      notifyListeners();
    }
  }

  void goToStep(int newStep) {
    step = newStep;
    notifyListeners();
  }

  void setPersonalData({
    required String dni,
    required String nombre,
    required String apellido,
    required String email,
    required String password,
  }) {
    this.dni = dni;
    this.nombre = nombre;
    this.apellido = apellido;
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  void setLevel(String level) {
    selectedLevel = level;
    notifyListeners();
  }

  void setGrades(Set<String> grades) {
    selectedGrades = grades;
    notifyListeners();
  }

  void setResponsibleGrade(String? grade) {
    responsibleGrade = grade;
    notifyListeners();
  }

  void setSubjects(Set<String> subjects) {
    selectedSubjects = subjects;
    notifyListeners();
  }

  void setResponsibleTeacher(bool value) {
    isResponsibleTeacher = value;
    notifyListeners();
  }

  void reset() {
    step = 0;
    selectedLevel = '';
    selectedGrades = {};
    responsibleGrade = null;
    selectedSubjects = {};
    isResponsibleTeacher = false;
    dni = '';
    nombre = '';
    apellido = '';
    email = '';
    password = '';
    notifyListeners();
  }
}
