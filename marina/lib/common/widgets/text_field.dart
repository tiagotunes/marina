import 'package:flutter/material.dart';

Widget textField({
  TextEditingController? controller,
  bool enabled = true,
  String? hint,
  String? label,
  String? helper,
  Widget? prefix,
  Widget? suffix,
  bool obscureText = false,
  bool readOnly = false,
  void Function(String value)? func,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      enabled: enabled,
      hintText: hint,
      isDense: true,
      labelText: label,
      helperText: helper,
      prefixIcon: prefix,
      suffixIcon: suffix,
    ),
    obscureText: obscureText,
    onChanged: func == null ? (_) {} : (value) => func(value),
    readOnly: readOnly,
  );
}
