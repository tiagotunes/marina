import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marina/common/widgets/popup_messages.dart';
import 'package:marina/pages/sign_up/notifier/register_notifier.dart';

class SignUpController {
  late WidgetRef ref;

  SignUpController({required this.ref});

  void handleSignUp() async {
    var state = ref.read(registerNotifierProvider);

    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;
    String username = state.username;
    String gender = state.gender;
    String role = state.role;

    print("--------------");
    print("Your email is $email");
    print("Your password is $password");
    print("Your rePassword is $rePassword");
    print("Your username is $username");
    print("Your gender is $gender");
    print("Your role is $role");
    print("--------------");

    if (state.password != state.rePassword) {
      toastInfo("Your password does not match");
    }
  }
}
