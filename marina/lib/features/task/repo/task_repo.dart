import 'package:dio/dio.dart';
import 'package:marina/common/services/http_util.dart';

class TaskRepo {
  static Future<Response> getTaskDetails(String taskId) async {
    final response = await HttpUtil().get('/tasks/$taskId');
    return response;
  }
}
