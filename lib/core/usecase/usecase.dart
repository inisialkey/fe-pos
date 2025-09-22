import 'package:dartz/dartz.dart';
import 'package:pos/core/core.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Class to handle when useCase don't need params
class NoParams {}
