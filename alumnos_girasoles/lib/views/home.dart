import 'package:flutter/material.dart';
import 'package:alumnos_girasoles/controllers/teach_controller.dart';
import 'package:alumnos_girasoles/widgets/button_card.dart';

class HomeScreen extends StatefulWidget {
  final int dni;

  const HomeScreen({super.key, required this.dni});
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
    teachController = TeachController();
    _futureGrades = teachController.obtainGradesNamesTaught(widget.dni);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 5, 72, 90),
            Color.fromARGB(255, 9, 70, 87), // Verde azulado oscuro
            Color.fromARGB(255, 56, 143, 170),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 160, 0),
                      Color.fromARGB(255, 255, 193, 7),
                    ],
                  ),
                ),
                accountName: const Text(
                  "Profesor Girasoles", // PONER NOMBRE DE CADA CUENTA
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                accountEmail: Text("DNI: ${widget.dni}"),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.orange, size: 40),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configuración'),
                onTap: () {
                  // IMPLEMENTAR
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Cerrar Sesión'),
                onTap: () {
                  // IMPLEMENTAR
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 70,
          title: Image.asset(
            'assets/icons/icon_girasol.png',
            width: 50,
            height: 50,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 255, 160, 0), // Naranja oscuro
                  Color.fromARGB(255, 255, 193, 7), // Amber
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
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
                      for (var grade in grades)
                        ButtonCard(element: grade, onTap: () {}),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
