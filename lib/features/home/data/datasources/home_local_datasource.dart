import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';
import 'package:pos/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

abstract class HomeLocalDatasource {
  Future<Either<Failure, Unit>> saveOrder(OrderModel order);
  Future<Either<Failure, List<OrderModel>>> getOrderByIsNotSync();
  Future<Either<Failure, List<OrderModel>>> getAllOrder(
    DateTime start,
    DateTime end,
  );
  Future<Either<Failure, List<ProductQuantity>>> getOrderItemByOrderId(
    int orderId,
  );
  Future<Either<Failure, Unit>> updateOrderIsSync(int orderId);
  Future<Either<Failure, Unit>> insertProduct(Product product);
  Future<Either<Failure, Unit>> insertProducts(List<Product> products);
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Product>>> getProductsByCategory(int categoryId);
  Future<Either<Failure, Product?>> getProductById(int productId);
  Future<Either<Failure, Unit>> deleteAllProducts();
  Future<Either<Failure, List<Product>>> searchProducts(String query);
  Future<Either<Failure, int>> getTotalProductsCount();
  Future<Either<Failure, int>> getTodayOrdersCount();
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  final DatabaseHelper _databaseHelper;

  HomeLocalDatasourceImpl(this._databaseHelper);

  /// Save order dengan order items
  @override
  Future<Either<Failure, Unit>> saveOrder(OrderModel order) async {
    try {
      final db = await _databaseHelper.database;

      // Mulai transaction untuk memastikan atomicity
      await db.transaction((txn) async {
        // Insert order dan dapatkan ID
        final int orderId = await txn.insert(
          Constants.get.tableProduct,
          order.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Insert semua order items
        for (final item in order.orderItems) {
          await txn.insert(
            Constants.get.tableOrderItem,
            item.toLocalMap(orderId),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });

      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error saving order: $e');
      return Left(CacheFailure());
    }
  }

  /// Get orders yang belum di-sync
  @override
  Future<Either<Failure, List<OrderModel>>> getOrderByIsNotSync() async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        Constants.get.tableOrder,
        where: 'is_sync = ?',
        whereArgs: [0],
      );

      final List<OrderModel> orders = maps
          .map((map) => OrderModel.fromMap(map))
          .toList();
      return Right(orders);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error getting unsynced orders: $e');
      return Left(CacheFailure());
    }
  }

  /// Get all orders dalam rentang tanggal
  @override
  Future<Either<Failure, List<OrderModel>>> getAllOrder(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final db = await _databaseHelper.database;

      // Format tanggal untuk query
      final startDate = DateFormat('yyyy-MM-dd').format(start);
      final endDate = DateFormat('yyyy-MM-dd').format(end);

      final List<Map<String, dynamic>> maps = await db.query(
        Constants.get.tableOrder,
        where: 'DATE(transaction_time) BETWEEN ? AND ?',
        whereArgs: [startDate, endDate],
        orderBy: 'transaction_time DESC',
      );

      final List<OrderModel> orders = maps
          .map((map) => OrderModel.fromMap(map))
          .toList();
      return Right(orders);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error getting orders by date range: $e');
      return Left(CacheFailure());
    }
  }

  /// Get order items berdasarkan order ID
  @override
  Future<Either<Failure, List<ProductQuantity>>> getOrderItemByOrderId(
    int orderId,
  ) async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        Constants.get.tableOrderItem,
        where: 'id_order = ?',
        whereArgs: [orderId],
      );

      final List<ProductQuantity> items = maps
          .map((map) => ProductQuantity.fromLocalMap(map))
          .toList();
      return Right(items);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error getting order items: $e');
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateOrderIsSync(int orderId) async {
    try {
      final db = await _databaseHelper.database;
      await db.update(
        Constants.get.tableOrder,
        {'is_sync': 1},
        where: 'id = ?',
        whereArgs: [orderId],
      );

      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error updating order sync status: $e');
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> insertProduct(Product product) async {
    try {
      final db = await _databaseHelper.database;
      await db.insert(
        Constants.get.tableProduct,
        product.toLocalMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      debugPrint('Product inserted successfully: ${product.name}');
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error inserting product: $e');
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> insertProducts(List<Product> products) async {
    try {
      final db = await _databaseHelper.database;

      // Gunakan batch untuk performa yang lebih baik
      final batch = db.batch();

      for (final product in products) {
        batch.insert(
          Constants.get.tableProduct,
          product.toLocalMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit();

      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error inserting products: $e');
      return Left(CacheFailure());
    }
  }

  /// Get all products
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        Constants.get.tableProduct,
        orderBy: 'name ASC',
      );

      final List<Product> products = maps
          .map((map) => Product.fromLocalMap(map))
          .toList();
      return Right(products);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error getting products: $e');
      return Left(CacheFailure());
    }
  }

  /// Get products by category
  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    int categoryId,
  ) async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        Constants.get.tableProduct,
        where: 'categoryId = ?',
        whereArgs: [categoryId],
        orderBy: 'name ASC',
      );

      final List<Product> products = maps
          .map((map) => Product.fromLocalMap(map))
          .toList();
      return Right(products);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error getting products by category: $e');
      return Left(CacheFailure());
    }
  }

  /// Get product by ID
  @override
  Future<Either<Failure, Product?>> getProductById(int productId) async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        Constants.get.tableProduct,
        where: 'productId = ?',
        whereArgs: [productId],
        limit: 1,
      );

      if (maps.isNotEmpty) {
        final product = Product.fromLocalMap(maps.first);
        return Right(product);
      } else {
        return const Right(null);
      }
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error getting product by id: $e');
      return Left(CacheFailure());
    }
  }

  /// Delete all products
  @override
  Future<Either<Failure, Unit>> deleteAllProducts() async {
    try {
      final db = await _databaseHelper.database;
      await db.delete(Constants.get.tableProduct);

      debugPrint('All products deleted successfully');
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error deleting all products: $e');
      return Left(CacheFailure());
    }
  }

  /// Search products by name
  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        Constants.get.tableProduct,
        where: 'name LIKE ? OR description LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
        orderBy: 'name ASC',
      );

      final List<Product> products = maps
          .map((map) => Product.fromLocalMap(map))
          .toList();
      return Right(products);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error searching products: $e');
      return Left(CacheFailure());
    }
  }

  /// Get total products count
  @override
  Future<Either<Failure, int>> getTotalProductsCount() async {
    try {
      final db = await _databaseHelper.database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $DatabaseHelper.tableProducts',
      );
      final count = Sqflite.firstIntValue(result) ?? 0;

      return Right(count);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error getting products count: $e');
      return Left(CacheFailure());
    }
  }

  /// Get total orders count for today
  @override
  Future<Either<Failure, int>> getTodayOrdersCount() async {
    try {
      final db = await _databaseHelper.database;
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $DatabaseHelper.tableOrders WHERE DATE(transaction_time) = ?',
        [today],
      );
      final count = Sqflite.firstIntValue(result) ?? 0;

      return Right(count);
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      debugPrint('Error getting today orders count: $e');
      return Left(CacheFailure());
    }
  }
}
