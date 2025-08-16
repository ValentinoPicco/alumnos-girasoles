import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Buenos Días ${Supabase.instance.client.auth.currentUser?.userMetadata?['name'] ?? ''}',
                  style: TextStyle(fontSize: 28.0),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                  ),
                  child: const Text('Cerrar Sesión'),
                  onPressed: () {
                    Supabase.instance.client.auth.signOut();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
