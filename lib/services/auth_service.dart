import '../models/user_role.dart';

class AuthService {
  // dummy users: username: role
  static final Map<String, UserRole> _users = {
    'admin': UserRole.admin,
    'guru': UserRole.guru,
    'siswa': UserRole.siswa,
  };

  Future<UserRole?> login(String username, String password) async {
    // password ignored in dummy login
    await Future.delayed(const Duration(milliseconds: 400));
    return _users[username];
  }
}
