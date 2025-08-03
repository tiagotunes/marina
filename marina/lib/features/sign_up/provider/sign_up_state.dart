class SignUpState {
  final String email;
  final String password;
  final String rePassword;
  final String name;
  final String gender;
  final String role;

  const SignUpState({
    this.email = "",
    this.password = "",
    this.rePassword = "",
    this.name = "",
    this.gender = "",
    this.role = "",
  });

  SignUpState copyWith({
    String? email,
    String? password,
    String? rePassword,
    String? name,
    String? gender,
    String? role,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      role: role ?? this.role,
    );
  }
}
