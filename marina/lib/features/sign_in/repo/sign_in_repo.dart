import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marina/common/utils/constants.dart';

class SignInRepo {
  static Future<http.Response> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('${Constants.SERVER_API_URL}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    return response;
  }
}
