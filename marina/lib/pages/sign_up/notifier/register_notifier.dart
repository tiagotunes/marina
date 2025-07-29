import 'package:marina/pages/sign_up/notifier/register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_notifier.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  @override
  RegisterState build() {
    return RegisterState();
  }

  void onEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChange(String password) {
    state = state.copyWith(password: password);
  }

  void onRePasswordChange(String rePassword) {
    state = state.copyWith(rePassword: rePassword);
  }

  void onUsernameChange(String username) {
    state = state.copyWith(username: username);
  }

  void onGenderChange(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onRoleChange(String role) {
    state = state.copyWith(role: role);
  }
}
