import 'package:dartz/dartz.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';

class GetProducts extends UseCase<Products, NoParams> {
  final HomeRepository _repo;

  GetProducts(this._repo);

  @override
  Future<Either<Failure, Products>> call(NoParams params) =>
      _repo.getProducts();
}
