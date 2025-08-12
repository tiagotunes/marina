import 'package:dio/dio.dart';
import 'package:marina/common/services/http_util.dart';

class TaskRepo {
  static Future<Response> getTaskDetails(String taskId) async {
    final response = await HttpUtil().get('/tasks/$taskId');
    return response;
  }

  static Future<Response> updateTaskDetails(
    String taskId,
    String measureId,
    int value,
  ) async {
    final response = await HttpUtil().put(
      '/tasks/$taskId/measures/$measureId',
      data: {'value': value},
    );
    return response;
  }
}
