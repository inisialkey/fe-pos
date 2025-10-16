import 'package:dartz/dartz.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';

abstract class HomeRepository {
  // Products
  Future<Either<Failure, Products>> getProducts();
  Future<Either<Failure, List<Product>>> getLocalProducts();
  Future<Either<Failure, List<Product>>> getProductsByCategory(int categoryId);
  Future<Either<Failure, List<Product>>> searchProducts(String query);
  Future<Either<Failure, Product?>> getProductById(int productId);

  // Sync
  Future<Either<Failure, Unit>> syncProducts();

  //Orders
  Future<Either<Failure, Unit>> saveOrder(OrderModel order);
  Future<Either<Failure, List<OrderModel>>> getOrdersByDateRange(
    DateTime start,
    DateTime end,
  );
  Future<Either<Failure, List<OrderModel>>> getUnsyncedOrders();
  Future<Either<Failure, List<ProductQuantity>>> getOrderItems(int orderId);

  // Statistics
  Future<Either<Failure, int>> getTotalProducts();
  Future<Either<Failure, int>> getTodayOrdersCount();
}
