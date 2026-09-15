import '../data/auth_service.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final UserProfile? profile;
  final String? errorMessage;

  const AuthState._({
    required this.status,
    this.profile,
    this.errorMessage,
  });

  const AuthState.initial() : this._(status: AuthStatus.initial);

  const AuthState.loading() : this._(status: AuthStatus.loading);

  const AuthState.authenticated(UserProfile profile)
      : this._(status: AuthStatus.authenticated, profile: profile);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  const AuthState.error(String message)
      : this._(status: AuthStatus.error, errorMessage: message);
}
