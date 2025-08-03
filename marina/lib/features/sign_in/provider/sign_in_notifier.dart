// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:marina/features/sign_in/provider/sign_in_state.dart';

// class SignInNotifier extends StateNotifier<SignInState> {
//   SignInNotifier() : super(SignInState());

//   void onEmailChange(String email) {
//     state = state.copyWith(email: email);
//   }

//   void onPasswordChange(String password) {
//     state = state.copyWith(password: password);
//   }
// }

// final signInNotifierProvider =
//     StateNotifierProvider<SignInNotifier, SignInState>(
//       (ref) => SignInNotifier(),
//     );

import 'package:marina/features/sign_in/provider/sign_in_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_notifier.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  @override
  SignInState build() {
    return SignInState();
  }

  void onEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChange(String password) {
    state = state.copyWith(password: password);
  }
}
