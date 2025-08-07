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
      // receiveTimeout: const Duration(seconds: 7),
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
          // print('Error - $exp');
          ErrorEntity eInfo = createErrorEntity(exp);
          onError(eInfo);
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

    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exveption";
    return "Exception code $code $message";
  }
}

ErrorEntity createErrorEntity(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: "Connection timed out");
    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: "Send timed out");
    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: "Receive timed out");
    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: "Bad SSL certificates");
    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case 400:
          return ErrorEntity(code: 400, message: "Request syntax error");
        case 401:
          return ErrorEntity(code: 401, message: "Permission denied");
      }
      return ErrorEntity(code: -1, message: "Bad response");
    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: "Server cancel");
    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: "Connection error");
    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: "Unknown error");
  }
}

void onError(ErrorEntity eInfo) {
  print('Error code -> ${eInfo.code} | Error message -> ${eInfo.message}');
  switch (eInfo.code) {
    case 400:
      print("Server syntax error");
      break;
    case 401:
      print("You are denied to continue");
      break;
    case 500:
      print("Internal server error");
      break;
    default:
      print("Unknown error");
      break;
  }
}
