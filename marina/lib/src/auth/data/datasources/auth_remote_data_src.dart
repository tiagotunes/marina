import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marina/core/common/app/cache_helper.dart';
import 'package:marina/core/common/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:marina/core/common/singletons/cache.dart';
import 'package:marina/core/errors/exceptions.dart';
import 'package:marina/core/extensions/string_extensions.dart';
import 'package:marina/core/services/injection_container.dart';
import 'package:marina/core/utils/constants/network_constants.dart';
import 'package:marina/core/utils/error_response.dart';
import 'package:marina/core/utils/network_utils.dart';
import 'package:marina/core/utils/typedefs.dart';

abstract class AuthRemoteDataSrc {
  const AuthRemoteDataSrc();

  Future<void> forgotPassword({required String email});

  Future<UserModel> login({required String email, required String password});

  Future<void> register({
    required String name,
    required String email,
    required String password,
    String gender,
  });

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  });

  Future<void> verifyOTP({required String email, required String otp});

  Future<bool> verifyToken();
}

const FORGOR_PASSWORD_ENDPOINT = '/forgot-password';
const LOGIN_ENDPOINT = '/login';
const REGISTER_ENDPOINT = '/register';
const RESET_PASSWORD_ENDPOINT = '/reset-password';
const VERIFY_OTP_ENDPOINT = '/verify-otp';
const VERIFY_TOKEN_ENDPOINT = '/verify-token';

class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  const AuthRemoteDataSrcImpl(this._client);
  final http.Client _client;

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/$FORGOR_PASSWORD_ENDPOINT',
      );

      final response = await _client.post(
        uri,
        headers: NetworkConstants.headers,
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Unknown Error', statusCode: 500);
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}/$LOGIN_ENDPOINT');

      final response = await _client.post(
        uri,
        headers: NetworkConstants.headers,
        body: jsonEncode({'email': email, 'password': password}),
      );

      final payload = jsonDecode(response.body) as DataMap;

      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      await sl<CacheHelper>().cacheSessionToken(payload['accessToken']);
      final user = UserModel.fromMap(payload);
      await sl<CacheHelper>().cacheUserId(user.id);
      return user;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Unknown Error', statusCode: 500);
    }
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? gender,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}/$REGISTER_ENDPOINT');

      final response = await _client.post(
        uri,
        headers: NetworkConstants.headers,
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'gender': gender,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Unknown Error', statusCode: 500);
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/$RESET_PASSWORD_ENDPOINT',
      );

      final response = await _client.post(
        uri,
        headers: NetworkConstants.headers,
        body: jsonEncode({'email': email, 'newPassword': newPassword}),
      );

      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Unknown Error', statusCode: 500);
    }
  }

  @override
  Future<void> verifyOTP({required String email, required String otp}) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}/$VERIFY_OTP_ENDPOINT');

      final response = await _client.post(
        uri,
        headers: NetworkConstants.headers,
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Unknown Error', statusCode: 500);
    }
  }

  @override
  Future<bool> verifyToken() async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}/$VERIFY_TOKEN_ENDPOINT',
      );

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      final payload = jsonDecode(response.body);
      await NetworkUtils.renewToken(response);

      if (response.statusCode != 200) {
        payload as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }

      return payload as bool;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Unknown Error', statusCode: 500);
    }
  }
}
