import 'package:equatable/equatable.dart';
import 'package:marina/core/usecase/usecase.dart';
import 'package:marina/core/utils/typedefs.dart';
import 'package:marina/src/auth/domain/repositories/auth_repository.dart';

class VerifyOTP extends UsecaseWithParam<void, VerifyOTPParams> {
  const VerifyOTP(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<void> call(VerifyOTPParams params) =>
      _repo.verifyOTP(email: params.email, otp: params.otp);
}

class VerifyOTPParams extends Equatable {
  const VerifyOTPParams({required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  List<Object?> get props => [email, otp];
}
