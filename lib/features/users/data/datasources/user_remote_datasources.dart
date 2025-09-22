import 'package:dartz/dartz.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/users/users.dart';

abstract class UsersRemoteDatasource {
  Future<Either<Failure, UsersResponse>> users(UsersParams userParams);

  Future<Either<Failure, UserResponse>> user();
}

class UsersRemoteDatasourceImpl implements UsersRemoteDatasource {
  final DioClient _client;

  UsersRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, UsersResponse>> users(UsersParams userParams) async {
    final response = await _client.getRequest(
      ListAPI.users,
      queryParameters: userParams.toJson(),
      converter: (response) =>
          UsersResponse.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }

  @override
  Future<Either<Failure, UserResponse>> user() async {
    final response = await _client.getRequest(
      ListAPI.user,
      converter: (response) =>
          UserResponse.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }
}
