import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:marina/core/common/app/cache_helper.dart';
import 'package:marina/core/services/injection_container.dart';
import 'package:marina/core/services/router.dart';

abstract class NetworkUtils {
  const NetworkUtils();

  static Future<void> renewToken(http.Response response) async {
    if (response.headers['authorization'] != null) {
      var token = response.headers['authorization'] as String;
      if (token.startsWith('Bearer')) {
        token = token.replaceFirst('Bearer', '').trim();
      }
      await sl<CacheHelper>().cacheSessionToken(token);
    } else if (response.statusCode == 401) {
      rootNavigatorKey.currentContext?.go('/');
    }
  }
}
