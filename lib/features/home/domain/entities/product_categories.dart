import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_categories.freezed.dart';

@freezed
sealed class ProductCategories with _$ProductCategories {
  const factory ProductCategories({
    String? id,
    String? name,
    String? description,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) = _ProductCategories;
}
