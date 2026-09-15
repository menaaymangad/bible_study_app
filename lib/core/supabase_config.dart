const String kSupabaseUrlKey = 'SUPABASE_URL';
const String kSupabaseAnonKeyKey = 'SUPABASE_ANON_KEY';

const String kUsernameEmailDomain = 'bibleschool.local';

/// Maps a username to a synthetic email for Supabase Auth.
/// e.g. 'mina123' -> 'mina123@bibleschool.local'
String usernameToEmail(String username) => '$username@$kUsernameEmailDomain';

class SupabaseConfig {
  SupabaseConfig._();

  static const String url = String.fromEnvironment(kSupabaseUrlKey);
  static const String anonKey = String.fromEnvironment(kSupabaseAnonKeyKey);

  static bool get isConfigured => url.isNotEmpty && anonKey.isNotEmpty;

  static void validate() {
    if (!isConfigured) {
      throw StateError(
        'Supabase is not configured. '
        'Run with: --dart-define=$kSupabaseUrlKey=... '
        '--dart-define=$kSupabaseAnonKeyKey=...',
      );
    }
  }
}
