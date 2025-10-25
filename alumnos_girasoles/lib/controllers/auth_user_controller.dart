import 'package:supabase_flutter/supabase_flutter.dart';

class AuthUserController {
  final supabase = Supabase.instance.client;

  Future<bool> existsEmail(String email) async {
    final result = await supabase
        .from('docentes')
        .select()
        .eq('email', email)
        .maybeSingle();
    return result != null;
  }
}
