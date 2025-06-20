import 'package:dartz/dartz.dart';
import 'package:marina/core/common/entities/user.dart';
import 'package:marina/core/errors/exceptions.dart';
import 'package:marina/core/errors/failures.dart';
import 'package:marina/core/utils/typedefs.dart';
import 'package:marina/src/user/data/datasources/user_remote_data_src.dart';
import 'package:marina/src/user/domain/repos/user_repo.dart';

class UserRepoImpl implements UserRepo {
  const UserRepoImpl(this._remoteDataSrc);

  final UserRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<User> getUser(String userId) async {
    try {
      final result = await _remoteDataSrc.getUser(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<User> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    try {
      final result = await _remoteDataSrc.updateUser(
        userId: userId,
        updateData: updateData,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
