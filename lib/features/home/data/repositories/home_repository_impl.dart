import 'package:dartz/dartz.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';

class HomeRepositoryImpl implements HomeRepository {
  /// Data Source
  final HomeRemoteDatasource homeRemoteDatasource;
  final HomeLocalDatasource homeLocalDatasource;

  const HomeRepositoryImpl(this.homeRemoteDatasource, this.homeLocalDatasource);

  @override
  Future<Either<Failure, Products>> getProducts() async {
    final response = await homeRemoteDatasource.getProducts();

    return response.fold(
      (failure) => Left(failure),
      (allProductResponse) => Right(allProductResponse.toEntity()),
    );
  }

  @override
  Future<Either<Failure, List<Product>>> getLocalProducts() async =>
      await homeLocalDatasource.getProducts();

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    int categoryId,
  ) async => await homeLocalDatasource.getProductsByCategory(categoryId);

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async =>
      await homeLocalDatasource.searchProducts(query);

  @override
  Future<Either<Failure, Product?>> getProductById(int productId) async =>
      await homeLocalDatasource.getProductById(productId);

  // Sync product from remote to local
  @override
  Future<Either<Failure, Unit>> syncProducts() async {
    try {
      // Get products dari remote
      final remoteResponse = await homeRemoteDatasource.getProducts();

      return await remoteResponse.fold((failure) => Left(failure), (
        productsResponse,
      ) async {
        // Convert ProductsResponse ke Products entity
        final productsEntity = productsResponse.toEntity();
        final products = productsEntity.products ?? [];

        if (products.isEmpty) {
          return const Right(unit);
        }

        // Delete semua products lama
        final deleteResult = await homeLocalDatasource.deleteAllProducts();

        return deleteResult.fold((failure) => Left(failure), (_) async {
          // Insert products baru (sudah dalam bentuk List<Product>)
          final insertResult = await homeLocalDatasource.insertProducts(
            products,
          );
          return insertResult;
        });
      });
    } catch (e) {
      return Left(ServerFailure('Failed to sync products: $e'));
    }
  }

  // Order Operation
  @override
  Future<Either<Failure, Unit>> saveOrder(OrderModel order) async =>
      await homeLocalDatasource.saveOrder(order);

  @override
  Future<Either<Failure, List<OrderModel>>> getOrdersByDateRange(
    DateTime start,
    DateTime end,
  ) async => await homeLocalDatasource.getAllOrder(start, end);

  @override
  Future<Either<Failure, List<OrderModel>>> getUnsyncedOrders() async =>
      await homeLocalDatasource.getOrderByIsNotSync();

  @override
  Future<Either<Failure, List<ProductQuantity>>> getOrderItems(
    int orderId,
  ) async => await homeLocalDatasource.getOrderItemByOrderId(orderId);

  // Statistic
  @override
  Future<Either<Failure, int>> getTotalProducts() async =>
      await homeLocalDatasource.getTotalProductsCount();

  @override
  Future<Either<Failure, int>> getTodayOrdersCount() async =>
      await homeLocalDatasource.getTodayOrdersCount();
}
