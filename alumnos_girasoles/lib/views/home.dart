import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/controllers/teach_controller.dart';

class HomeScreen extends StatefulWidget {
  final int? dni;

  const HomeScreen({super.key, this.dni});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TeachController teachController;
  late Future<Set<String>> _futureGrades;

  @override
  void initState() {
    super.initState();
    teachController = TeachController(widget.dni);
    _futureGrades = teachController.obtainGradesNamesTaught();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: FutureBuilder(
        future: _futureGrades,
        builder: (context, snapshot) {
          // ESTADO 1: CARGANDO
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          // ESTADO 2: ERROR
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // ESTADO 3: DATOS LISTOS
          // Si no hay datos, usamos un set vacío por seguridad
          final Set<String> grades = snapshot.data ?? <String>{};

          if (grades.isEmpty) {
            return const Center(child: Text('No hay grados cargados'));
          }
          return Center(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (var i = 0; i < grades.length; i++) ...[
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(
                                  255,
                                  9,
                                  70,
                                  87,
                                ), // Verde azulado oscuro
                                Color.fromARGB(255, 56, 143, 170),
                              ],
                            ),
                          ),
                          child: SizedBox(
                            width: 270,
                            height: 150,
                            child: Center(
                              child: Text(
                                grades.elementAt(i).toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
