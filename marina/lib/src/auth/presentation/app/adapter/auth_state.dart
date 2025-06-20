part of 'auth_adapter.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// THE INITIAL STATES
// -------------------
final class AuthInitial extends AuthState {
  const AuthInitial();
}

//? THE LOADING STATES
//? -------------------
final class AuthLoading extends AuthState {
  const AuthLoading();
}

//* THE SUCCESS STATES
//* -------------------
final class OTPSent extends AuthState {
  const OTPSent();
}

final class LoggedIn extends AuthState {
  const LoggedIn(this.user);
  final User user;
  @override
  List<Object?> get props => [user];
}

final class Registered extends AuthState {
  const Registered();
}

final class PasswordReset extends AuthState {
  const PasswordReset();
}

final class OTPVerified extends AuthState {
  const OTPVerified();
}

final class TokenVerified extends AuthState {
  const TokenVerified(this.isValid);
  final bool isValid;
  @override
  List<Object?> get props => [isValid];
}

//! THE ERROR STATE
//! ----------------
final class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
