import 'package:dartz/dartz.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';

class GetLocalProduct extends UseCase<List<Product>, NoParams> {
  final HomeRepository _repo;

  GetLocalProduct(this._repo);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) =>
      _repo.getLocalProducts();
}
