import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_repo.dart';

class SupabaseAuthRepository implements AuthRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (res.user == null) {
        throw Exception('User registration failed');
      }
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user == null) {
        throw Exception('Login failed');
      }
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  Stream<bool> get isAuthenticated {
    return supabase.auth.onAuthStateChange
        .map((event) => event.session != null);
  }

  @override
  String? get currentUserId => supabase.auth.currentUser?.id;
}
