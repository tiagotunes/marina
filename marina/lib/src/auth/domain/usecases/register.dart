import 'package:equatable/equatable.dart';
import 'package:marina/core/usecase/usecase.dart';
import 'package:marina/core/utils/typedefs.dart';
import 'package:marina/src/auth/domain/repos/auth_repo.dart';

class Register extends UsecaseWithParams<void, RegisterParams> {
  const Register(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(RegisterParams params) => _repo.register(
    name: params.name,
    email: params.email,
    password: params.password,
    gender: params.gender!,
  );
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    this.gender,
  });

  final String name;
  final String email;
  final String password;
  final String? gender;

  @override
  List<Object?> get props => [name, email, password, gender];
}
