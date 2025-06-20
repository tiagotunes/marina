import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:marina/core/common/app/riverpod/current_user_provider.dart';
import 'package:marina/core/common/entities/user.dart';
import 'package:marina/core/services/injection_container.dart';
import 'package:marina/src/auth/domain/usecases/forgot_password.dart';
import 'package:marina/src/auth/domain/usecases/login.dart';
import 'package:marina/src/auth/domain/usecases/register.dart';
import 'package:marina/src/auth/domain/usecases/reset_password.dart';
import 'package:marina/src/auth/domain/usecases/verify_otp.dart';
import 'package:marina/src/auth/domain/usecases/verify_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_adapter.g.dart';
part 'auth_state.dart';

@riverpod
class AuthAdapter extends _$AuthAdapter {
  @override
  AuthState build([GlobalKey? familyKey]) {
    _forgotPassword = sl<ForgotPassword>();
    _login = sl<Login>();
    _register = sl<Register>();
    _resetPassword = sl<ResetPassword>();
    _verifyOTP = sl<VerifyOTP>();
    _verifyToken = sl<VerifyToken>();
    return const AuthInitial();
  }

  late ForgotPassword _forgotPassword;
  late Login _login;
  late Register _register;
  late ResetPassword _resetPassword;
  late VerifyOTP _verifyOTP;
  late VerifyToken _verifyToken;

  Future<void> forgotPassword({required String email}) async {
    state = const AuthLoading();

    final result = await _forgotPassword(email);
    result.fold(
      (failure) {
        state = AuthError(failure.errorMessage);
      },
      (_) {
        state = const OTPSent();
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthLoading();
    final result = await _login(LoginParams(email: email, password: password));
    result.fold(
      (faliure) {
        state = AuthError(faliure.errorMessage);
      },
      (user) {
        ref.read(currentUserProvider.notifier).setuser(user);
        state = LoggedIn(user);
      },
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? gender,
  }) async {
    state = const AuthLoading();
    final result = await _register(
      RegisterParams(
        name: name,
        email: email,
        password: password,
        gender: gender,
      ),
    );

    result.fold(
      (failure) {
        state = AuthError(failure.errorMessage);
      },
      (_) {
        state = const Registered();
      },
    );
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    state = const AuthLoading();
    final result = await _resetPassword(
      ResetPasswordParams(email: email, newPassword: newPassword),
    );
    result.fold(
      (failure) {
        state = AuthError(failure.errorMessage);
      },
      (_) {
        state = const PasswordReset();
      },
    );
  }

  Future<void> verifyOTP({required String email, required String otp}) async {
    state = const AuthLoading();
    final result = await _verifyOTP(VerifyOTPParams(email: email, otp: otp));
    result.fold(
      (failure) {
        state = AuthError(failure.errorMessage);
      },
      (_) {
        state = const OTPVerified();
      },
    );
  }

  Future<void> verifyToken() async {
    state = const AuthLoading();
    final result = await _verifyToken();
    result.fold(
      (failure) {
        state = AuthError(failure.errorMessage);
      },
      (isValid) {
        state = TokenVerified(isValid);
        if (!isValid) ref.read(currentUserProvider.notifier).setuser(null);
      },
    );
  }
}
