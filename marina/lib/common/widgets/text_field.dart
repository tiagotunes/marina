import 'package:flutter/material.dart';

Widget textField({
  TextEditingController? controller,
  String label = "<label>",
  IconData icon = Icons.error_outline_sharp,
  bool obscureText = false,
  void Function(String value)? func,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
    obscureText: obscureText,
    onChanged: (value) => func!(value),
  );
}
