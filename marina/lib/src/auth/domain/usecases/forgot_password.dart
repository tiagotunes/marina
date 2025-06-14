import 'package:marina/core/usecase/usecase.dart';
import 'package:marina/core/utils/typedefs.dart';
import 'package:marina/src/auth/domain/repositories/auth_repository.dart';

class ForgotPassword extends UsecaseWithParam<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(email: params);
}
