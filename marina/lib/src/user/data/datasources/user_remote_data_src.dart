import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:marina/core/common/models/user_model.dart';
import 'package:marina/core/common/singletons/cache.dart';
import 'package:marina/core/errors/exceptions.dart';
import 'package:marina/core/extensions/string_extensions.dart';
import 'package:marina/core/utils/constants/network_constants.dart';
import 'package:marina/core/utils/error_response.dart';
import 'package:marina/core/utils/network_utils.dart';
import 'package:marina/core/utils/typedefs.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSrc {
  Future<UserModel> getUser(String userId);

  Future<UserModel> updateUser({
    required String userId,
    required DataMap updateData,
  });
}

const USERS_ENDPOINT = '/users';

class UserRemoteDataSrcImpl implements UserRemoteDataSrc {
  const UserRemoteDataSrcImpl(this._client);
  final http.Client _client;

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$USERS_ENDPOINT/$userId',
      );

      final response = await _client.get(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
      );

      final payload = jsonDecode(response.body) as DataMap;
      await NetworkUtils.renewToken(response);

      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }

      return UserModel.fromMap(payload);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Unknown Error', statusCode: 500);
    }
  }

  @override
  Future<UserModel> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$USERS_ENDPOINT/$userId',
      );

      final response = await _client.put(
        uri,
        headers: Cache.instance.sessionToken!.toAuthHeaders,
        body: jsonEncode(updateData),
      );

      final payload = jsonDecode(response.body) as DataMap;
      await NetworkUtils.renewToken(response);

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }

      return UserModel.fromMap(payload);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: 'Unknown Error', statusCode: 500);
    }
  }
}
