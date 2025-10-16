import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/features.dart';

part 'products.freezed.dart';
part 'products.g.dart';

@freezed
sealed class Products with _$Products {
  const factory Products({List<Product>? products}) = _Users;

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
}

@freezed
sealed class Product with _$Product {
  const factory Product({
    int? id,
    int? categoryId,
    String? name,
    String? description,
    String? image,
    String? price,
    int? stock,
    int? status,
    int? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    Category? category,
  }) = _Product;
  const Product._();

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  factory Product.fromOrderMap(Map<String, dynamic> json) => Product(
    id: (json['id_product'] as num?)?.toInt(),
    price: json['price']?.toString(),
  );

  // Factory method untuk membaca dari local database
  factory Product.fromLocalMap(Map<String, dynamic> json) => Product(
    id: json['id'] as int?,
    categoryId: json['categoryId'] as int?,
    category: Category(
      id: json['categoryId'] as int?,
      name: json['categoryName'] as String?,
    ),
    name: json['name'] as String?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    price: json['price'] as String?,
    stock: json['stock'] as int?,
    status: json['status'] as int?,
    isFavorite: json['isFavorite'] as int?,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'] as String)
        : null,
  );

  // Method untuk convert ke local database map
  Map<String, dynamic> toLocalMap() => {
    'id': id,
    'productId': id, // productId sama dengan id
    'name': name,
    'categoryId': categoryId,
    'categoryName': category?.name, // Ambil dari category jika ada
    'description': description,
    'image': image,
    'price': price,
    'stock': stock ?? 0,
    'status': status ?? 1,
    'isFavorite': isFavorite ?? 0,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
