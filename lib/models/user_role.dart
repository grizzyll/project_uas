enum UserRole { admin, guru, siswa }

String roleToString(UserRole r) {
  return r.toString().split('.').last;
}
