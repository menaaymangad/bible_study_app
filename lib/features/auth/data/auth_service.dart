import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/supabase_config.dart';

class UserProfile {
  final String id;
  final String name;
  final String username;
  final String role;
  final String? academicYearId;

  const UserProfile({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    this.academicYearId,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      name: map['name'] as String,
      username: map['username'] as String,
      role: map['role'] as String,
      academicYearId: map['academic_year_id'] as String?,
    );
  }

  bool get isAdmin => role == 'admin';
}

class AuthService {
  final SupabaseClient _client;

  AuthService({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  Future<AuthResponse> signIn({
    required String username,
    required String password,
  }) async {
    final email = usernameToEmail(username);
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<UserProfile> getProfile(String userId) async {
    final data =
        await _client.from('profiles').select().eq('id', userId).single();
    return UserProfile.fromMap(data);
  }
}
