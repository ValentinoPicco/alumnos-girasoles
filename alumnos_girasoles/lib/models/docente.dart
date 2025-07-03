class Docente {
  final int dni;
  final String surname;
  final String name;
  final String email;
  final String password;

  Docente({
    required this.dni,
    required this.surname,
    required this.name,
    required this.email,
    required this.password,
  });

  factory Docente.fromMap(Map<String, dynamic> map) {
    return Docente(
      dni: map['dni'],
      surname: map['surname'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dni': dni,
      'surname': surname,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
