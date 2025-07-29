import 'package:flutter/material.dart';

Widget signInTextFields() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          prefixIcon: Icon(Icons.email),
        ),
      ),
      SizedBox(height: 24),
      TextField(
        autocorrect: false,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Palavra-passe',
          prefixIcon: Icon(Icons.password),
        ),
      ),
    ],
  );
}
