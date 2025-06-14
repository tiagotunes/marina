import 'package:equatable/equatable.dart';
import 'package:marina/core/common/entities/user.dart';
import 'package:marina/core/usecase/usecase.dart';
import 'package:marina/core/utils/typedefs.dart';
import 'package:marina/src/auth/domain/repositories/auth_repository.dart';

class Login extends UsecaseWithParam<User, LoginParams> {
  const Login(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<User> call(LoginParams params) =>
      _repo.login(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});

  const LoginParams.empty() : email = 'empty', password = 'empty';

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
