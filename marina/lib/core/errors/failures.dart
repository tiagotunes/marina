import 'package:equatable/equatable.dart';
import 'package:marina/core/errors/exceptions.dart';

sealed class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException e)
    : this(message: e.message, statusCode: e.statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message}) : super(statusCode: 3);

  CacheFailure.fromException(CacheException e) : this(message: e.message);
}
