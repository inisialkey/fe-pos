import 'package:dartz/dartz.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/auth/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Login>> login(LoginParams params);

  Future<Either<Failure, GeneralToken>> generalToken(GeneralTokenParams params);

  Future<Either<Failure, String>> logout();
}
