class AuthService {
  // 🧠 Simple in-memory user storage
  static final Map<String, Map<String, dynamic>> _users = {};

  static String? _currentUserEmail;

  /// REGISTER
  static Future<bool> registerUser(
    String username,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300)); // fake delay

    // ❌ Email already exists
    if (_users.containsKey(email)) {
      return false;
    }

    _users[email] = {
      'username': username,
      'email': email,
      'password': password, // ⚠️ plaintext (OK for offline demo)
      'xp': 0,
      'createdAt': DateTime.now(),
    };

    _currentUserEmail = email;
    return true;
  }

  /// LOGIN
  static Future<bool> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300)); // fake delay

    if (!_users.containsKey(email)) return false;
    if (_users[email]!['password'] != password) return false;

    _currentUserEmail = email;
    return true;
  }

  /// LOGOUT
  static void logout() {
    _currentUserEmail = null;
  }

  /// CURRENT USER
  static Map<String, dynamic>? get currentUser {
    if (_currentUserEmail == null) return null;
    return _users[_currentUserEmail];
  }
}
