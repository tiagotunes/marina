import 'package:marina/core/usecase/usecase.dart';
import 'package:marina/core/utils/typedefs.dart';
import 'package:marina/src/auth/domain/repos/auth_repo.dart';

class VerifyToken extends UsecaseWithoutParam<bool> {
  const VerifyToken(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.verifyToken();
}
