import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marina/common/utils/constants.dart';

class SignUpRepo {
  static Future<http.Response> signIn(
    String email,
    String password,
    String name,
  ) async {
    final response = await http.post(
      Uri.parse('${Constants.SERVER_API_URL}/register'),
      headers: {
        'Content-Type':
            'application/json', // 'application/x-www-form-urlencoded' or whatever you need
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "status": "active",
      }),
    );

    return response;
  }
}
