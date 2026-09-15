import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(const AuthState.initial());

  Future<void> checkAuth() async {
    final user = _authService.currentUser;
    if (user == null) {
      emit(const AuthState.unauthenticated());
      return;
    }
    await _loadProfile(user.id);
  }

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    emit(const AuthState.loading());
    try {
      final response = await _authService.signIn(
        username: username,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        emit(const AuthState.unauthenticated());
        return;
      }
      await _loadProfile(user.id);
    } on Exception catch (e) {
      emit(AuthState.error(_friendlyMessage(e)));
    }
  }

  Future<void> signOut() async {
    emit(const AuthState.loading());
    try {
      await _authService.signOut();
      emit(const AuthState.unauthenticated());
    } on Exception catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> _loadProfile(String userId) async {
    try {
      final profile = await _authService.getProfile(userId);
      emit(AuthState.authenticated(profile));
    } on Exception catch (e) {
      emit(AuthState.error('Failed to load profile: $e'));
    }
  }

  String _friendlyMessage(Exception e) {
    final msg = e.toString();
    if (msg.contains('Invalid login credentials')) {
      return 'Invalid username or password.';
    }
    return 'Sign in failed. Please try again.';
  }
}
