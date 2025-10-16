import 'package:dartz/dartz.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';

abstract class HomeRemoteDatasource {
  Future<Either<Failure, ProductsResponse>> getProducts();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final DioClient _client;

  HomeRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, ProductsResponse>> getProducts() async {
    final response = await _client.getRequest(
      ListAPI.allProduct,
      converter: (response) =>
          ProductsResponse.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }
}
