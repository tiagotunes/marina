import 'package:marina/features/sign_up/provider/sign_up_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_notifier.g.dart';

@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  @override
  SignUpState build() {
    return SignUpState();
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

  void onNameChange(String name) {
    state = state.copyWith(name: name);
  }

  void onGenderChange(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onRoleChange(String role) {
    state = state.copyWith(role: role);
  }
}
