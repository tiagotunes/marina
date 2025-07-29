import 'package:flutter/material.dart';

Widget signUpTextField({
  String label = "<label>",
  IconData icon = Icons.error_outline_sharp,
  bool obscureText = false,
  void Function(String value)? func,
}) {
  return TextField(
    decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
    obscureText: obscureText,
    onChanged: (value) => func!(value),
  );
}
