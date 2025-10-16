import 'package:dartz/dartz.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';

class SyncProduct extends UseCase<Unit, NoParams> {
  final HomeRepository _repo;

  SyncProduct(this._repo);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => _repo.syncProducts();
}
