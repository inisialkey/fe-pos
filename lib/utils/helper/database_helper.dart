import 'dart:io';
import 'package:path/path.dart';
import 'package:pos/core/core.dart';
import 'package:pos/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton pattern
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper();

  // Getter dengan error handling yang lebih baik
  Future<Database> get database async {
    try {
      _database ??= await _initDatabase();
      return _database!;
    } catch (e) {
      throw CacheException();
    }
  }

  // Initialize database dengan error handling
  Future<Database> _initDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, Constants.get.databaseName);

      // Pastikan direktori ada
      final directory = Directory(dirname(path));
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      return await openDatabase(
        path,
        version: Constants.get.databaseVersion,
        onCreate: _onCreate,
        onOpen: _onOpen,
      );
    } catch (e) {
      throw CacheException();
    }
  }

  // Callback saat database dibuka
  Future<void> _onOpen(Database db) async {
    // Enable foreign key constraints
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // Create tables dengan foreign key constraints dan indexing
  Future<void> _onCreate(Database db, int version) async {
    try {
      // Products table
      await db.execute('''
        CREATE TABLE ${Constants.get.tableProduct} (
          id INTEGER PRIMARY KEY,
          productId INTEGER UNIQUE,
          name TEXT NOT NULL,
          categoryId INTEGER,
          categoryName TEXT,
          description TEXT,
          image TEXT,
          price TEXT,
          stock INTEGER DEFAULT 0,
          status INTEGER DEFAULT 1,
          isFavorite INTEGER DEFAULT 0,
          createdAt TEXT,
          updatedAt TEXT
        )
      ''');

      // Orders table
      await db.execute('''
        CREATE TABLE ${Constants.get.tableOrder} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          payment_amount INTEGER NOT NULL,
          sub_total INTEGER NOT NULL,
          tax INTEGER DEFAULT 0,
          discount INTEGER DEFAULT 0,
          service_charge INTEGER DEFAULT 0,
          total INTEGER NOT NULL,
          payment_method TEXT NOT NULL,
          total_item INTEGER NOT NULL,
          id_kasir INTEGER NOT NULL,
          nama_kasir TEXT NOT NULL,
          transaction_time TEXT NOT NULL,
          is_sync INTEGER DEFAULT 0
        )
      ''');

      // Order items table dengan foreign key
      await db.execute('''
        CREATE TABLE ${Constants.get.tableOrderItem} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          id_order INTEGER NOT NULL,
          id_product INTEGER NOT NULL,
          quantity INTEGER NOT NULL CHECK(quantity > 0),
          price INTEGER NOT NULL,
          FOREIGN KEY (id_order) REFERENCES ${Constants.get.tableOrder} (id) ON DELETE CASCADE,
          FOREIGN KEY (id_product) REFERENCES ${Constants.get.tableProduct} (id) ON DELETE CASCADE
        )
      ''');

      // Create indexes untuk performa yang lebih baik
      await _createIndexes(db);
    } catch (e) {
      throw CacheException();
    }
  }

  // Create indexes untuk optimasi query
  Future<void> _createIndexes(Database db) async {
    await db.execute(
      'CREATE INDEX idx_products_productId ON ${Constants.get.tableProduct}(productId)',
    );
    await db.execute(
      'CREATE INDEX idx_products_categoryId ON ${Constants.get.tableProduct}(categoryId)',
    );
    await db.execute(
      'CREATE INDEX idx_orders_transaction_time ON ${Constants.get.tableOrder}(transaction_time)',
    );
    await db.execute(
      'CREATE INDEX idx_orders_is_sync ON ${Constants.get.tableOrder}(is_sync)',
    );
    await db.execute(
      'CREATE INDEX idx_order_items_id_order ON ${Constants.get.tableOrderItem}(id_order)',
    );
    await db.execute(
      'CREATE INDEX idx_order_items_id_product ON ${Constants.get.tableOrderItem}(id_product)',
    );
  }

  // Method untuk menutup database dengan aman
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  // Method untuk backup database
  Future<String> backupDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final sourcePath = join(dbPath, Constants.get.databaseName);
      final backupPath = join(
        dbPath,
        'backup_${DateTime.now().millisecondsSinceEpoch}_$Constants.get.databaseName',
      );

      final sourceFile = File(sourcePath);
      if (await sourceFile.exists()) {
        await sourceFile.copy(backupPath);
        return backupPath;
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
