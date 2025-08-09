import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastInfo(String msg, {Color backgroundColor = Colors.blue}) {
  return Fluttertoast.showToast(
    backgroundColor: backgroundColor,
    gravity: ToastGravity.TOP,
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
  );
}
