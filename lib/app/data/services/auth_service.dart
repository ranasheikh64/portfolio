import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends GetxService {
  final _supabase = Supabase.instance.client;
  var isAuthenticated = false.obs;

  Future<AuthService> init() async {
    // Check current session
    final session = _supabase.auth.currentSession;
    isAuthenticated.value = session != null;

    // Listen to auth state changes
    _supabase.auth.onAuthStateChange.listen((data) {
      isAuthenticated.value = data.session != null;
    });

    return this;
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      // Supabase Auth automatically persists session, so we can just check current user
      if (response.user != null) {
        isAuthenticated.value = true;
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        // Auto login usually happens on signup, but check config
        isAuthenticated.value = true;
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar("Error", "Sign up failed: $e");
      return false;
    }
  }

  void logout() async {
    await _supabase.auth.signOut();
    Get.offAllNamed('/login'); // Ensure redirect
  }
}
