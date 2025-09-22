import 'package:dartz/dartz.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/users/users.dart';

abstract class UsersRepository {
  Future<Either<Failure, Users>> users(UsersParams usersParams);

  Future<Either<Failure, User>> user();
}
