class RegisterState {
  final String email;
  final String password;
  final String rePassword;
  final String username;
  final String gender;
  final String role;

  RegisterState({
    this.email = "",
    this.password = "",
    this.rePassword = "",
    this.username = "",
    this.gender = "",
    this.role = "",
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? rePassword,
    String? username,
    String? gender,
    String? role,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      role: role ?? this.role,
    );
  }
}
