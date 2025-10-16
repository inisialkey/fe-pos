import 'package:pos/features/features.dart';
import 'package:pos/utils/utils.dart';

class ProductModel {
  final String image;
  final String name;
  final ProductCategory category;
  final int price;
  final int stock;

  ProductModel({
    required this.image,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
  });

  String get priceFormat => price.currencyFormatRp;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ProductModel &&
        other.image == image &&
        other.name == name &&
        other.category == category &&
        other.price == price &&
        other.stock == stock;
  }

  @override
  int get hashCode =>
      image.hashCode ^
      name.hashCode ^
      category.hashCode ^
      price.hashCode ^
      stock.hashCode;
}
