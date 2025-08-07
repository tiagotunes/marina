import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:marina/common/services/http_util.dart';

class SignInRepo {
  static Future<Response> signIn(String email, String password) async {
    var response = await HttpUtil().post(
      '/login',
      data: jsonEncode({'email': email, 'password': password}),
    );
    return response;
  }
}
