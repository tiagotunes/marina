import 'package:dio/dio.dart';
import 'package:marina/common/services/http_util.dart';

class HomeRepo {
  static Future<Response> getUserTasks(String userId) async {
    final response = await HttpUtil().get('/users/$userId/tasks');
    return response;
  }
}
