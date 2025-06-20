import 'package:marina/core/common/entities/user.dart';
import 'package:marina/core/utils/typedefs.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<void> forgotPassword({required String email});
  ResultFuture<User> login({required String email, required String password});
  ResultFuture<void> register({
    required String name,
    required String email,
    required String password,
    String gender,
  });
  ResultFuture<void> resetPassword({
    required String email,
    required String newPassword,
  });
  ResultFuture<void> verifyOTP({required String email, required String otp});
  ResultFuture<bool> verifyToken();
}
