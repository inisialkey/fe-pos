import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/features.dart';

part 'products_response.freezed.dart';
part 'products_response.g.dart';

@freezed
sealed class ProductsResponse with _$ProductsResponse {
  const factory ProductsResponse({
    Diagnostic? diagnostic,
    List<DataProduct>? data,
  }) = _ProductsResponse;

  const ProductsResponse._();

  Products toEntity() => Products(
    products: data
        ?.map(
          (data) => Product(
            id: data.id,
            categoryId: data.categoryId,
            name: data.name,
            description: data.description,
            image: data.image,
            price: data.price,
            stock: data.stock,
            status: data.status,
            isFavorite: data.isFavorite,
            createdAt: data.createdAt,
            updatedAt: data.updatedAt,
            category: Category(
              id: data.category?.id,
              name: data.category?.name,
              description: data.category?.description,
              image: data.category?.image,
              createdAt: data.category?.createdAt,
              updatedAt: data.category?.updatedAt,
            ),
          ),
        )
        .toList(),
  );
  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);
}

@freezed
sealed class DataProduct with _$DataProduct {
  const factory DataProduct({
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
  }) = _DataProduct;

  factory DataProduct.fromJson(Map<String, dynamic> json) =>
      _$DataProductFromJson(json);
}

@freezed
sealed class Category with _$Category {
  const factory Category({
    int? id,
    String? name,
    String? description,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
