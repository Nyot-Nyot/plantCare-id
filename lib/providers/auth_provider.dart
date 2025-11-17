import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Local guest mode flag. When true the app treats the session as a local
/// guest and avoids creating any accounts on Supabase. This is the preferred
/// approach for demo/preview mode so we don't pollute the Supabase project
/// with transient accounts.
final guestModeProvider = StateProvider<bool>((ref) => false);

/// Provides the current authenticated user as a Stream of User (or null).
/// If Supabase is not initialized, the stream will emit `null`.
final authUserProvider = StreamProvider<User?>((ref) {
  try {
    final client = Supabase.instance.client;
    // Map auth state changes to User?
    return client.auth.onAuthStateChange.map((event) => event.session?.user);
  } catch (_) {
    // Supabase not initialized yet; return a single null value stream.
    return Stream<User?>.value(null);
  }
});

/// Simple helper repository for auth actions.
class AuthRepository {
  final SupabaseClient _client;
  AuthRepository(this._client);

  Future<void> signIn(String email, String password) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    await _client.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Update profile information for the current user.
  ///
  /// `username` will be stored inside the user's metadata under the
  /// `username` key. `password` will update the user's password.
  Future<void> updateProfile({String? username, String? password}) async {
    // Build attributes using the Supabase UserAttributes helper if available.
    try {
      // The supabase_flutter package exposes updateUser via auth.updateUser
      await _client.auth.updateUser(
        UserAttributes(
          password: password,
          data: username != null ? {'username': username} : null,
        ),
      );
    } catch (e) {
      // Re-throw for caller to handle UI errors
      rethrow;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(Supabase.instance.client);
});
