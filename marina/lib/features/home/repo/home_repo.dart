import 'package:dio/dio.dart';
import 'package:marina/common/services/http_util.dart';

class HomeRepo {
  static Future<Response> fetchUserTasks(String userId) async {
    final response = await HttpUtil().get('/users/$userId/tasks');
    return response;
  }

  static Future<Response> createUserTasks(String userId) async {
    final response = await HttpUtil().post('/users/$userId/tasks');
    return response;
  }
}
