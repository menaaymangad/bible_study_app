const String kUsernameEmailDomain = 'bibleschool.local';

/// Maps a username to a synthetic email for Supabase Auth.
/// e.g. 'mina123' -> 'mina123@bibleschool.local'
String usernameToEmail(String username) => '$username@$kUsernameEmailDomain';

class SupabaseConfig {
  SupabaseConfig._();

  // TODO: Replace with your real Supabase project values.
  static const String url = '';
  static const String anonKey = '';
}
