import 'package:dio/dio.dart';
import 'package:marina/common/utils/constants.dart';
import 'package:marina/common/utils/typedefs.dart';
import 'package:marina/global.dart';

class HttpUtil {
  late Dio dio;
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Constants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 7),
      receiveTimeout: const Duration(seconds: 7),
      headers: {},
      contentType: "application/json",
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // print('New request - ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // print('New response - ${response.data}');
          return handler.next(response);
        },
        onError: (DioException exp, handler) {
          String message = "Unknown error";

          if (exp.response != null && exp.response?.data != null) {
            if (exp.response?.data is Map &&
                exp.response?.data['message'] != null) {
              message = exp.response?.data['message'];
            } else if (exp.response?.data is String) {
              message = exp.response?.data;
            }
          } else {
            message = mapDioErrors(exp);
          }

          handler.reject(
            DioException(
              requestOptions: exp.requestOptions,
              response: exp.response,
              type: exp.type,
              error: message,
            ),
          );
        },
      ),
    );
  }

  DataMap? getAuthorizationHeader() {
    var headers = DataMap();
    var acessToken = Global.storageService.getUserToken();

    if (acessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $acessToken';
    }
    return headers;
  }

  Future<Response> get(
    String path, {
    DataMap? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};

    DataMap? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    return await dio.get(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
    );
  }

  Future<Response> post(
    String path, {
    Object? data,
    DataMap? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};

    DataMap? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
  }

  Future<bool> isTokenValid() async {
    try {
      final res = await get('/verify-token');
      if (res.data) {
        return true;
      } else {
        await Global.storageService.removeUserPrefs();
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

String mapDioErrors(DioException exp) {
  switch (exp.type) {
    case DioExceptionType.connectionTimeout:
      return "Connection timed out";
    case DioExceptionType.sendTimeout:
      return "Send timed out";
    case DioExceptionType.receiveTimeout:
      return "Receive timed out";
    case DioExceptionType.badCertificate:
      return "Bad SSL certificate";
    case DioExceptionType.cancel:
      return "Request cancelled";
    case DioExceptionType.connectionError:
      return "Connection error";
    case DioExceptionType.unknown:
      return "Unknown error";
    default:
      return "Request failed";
  }
}
