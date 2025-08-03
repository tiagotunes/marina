import 'package:flutter/material.dart';

Widget signUpButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/signUp');
    },
    child: Center(child: Text("Registar")),
  );
}
