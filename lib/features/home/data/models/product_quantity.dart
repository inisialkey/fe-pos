import 'dart:convert';

import 'package:pos/features/features.dart';

class ProductQuantity {
  final Product product;
  int quantity;
  ProductQuantity({required this.product, required this.quantity});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ProductQuantity &&
        other.product == product &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  Map<String, dynamic> toMap() => {
    'product': product.toJson(),
    'quantity': quantity,
  };

  Map<String, dynamic> toLocalMap(int orderId) => {
    'id_order': orderId,
    'id_product': product.id,
    'quantity': quantity,
    'price': product.price,
  };

  factory ProductQuantity.fromMap(Map<String, dynamic> map) => ProductQuantity(
    product: Product.fromJson(map['product'] as Map<String, dynamic>),
    quantity: (map['quantity'] as num?)?.toInt() ?? 0,
  );

  factory ProductQuantity.fromLocalMap(Map<String, dynamic> map) =>
      ProductQuantity(
        product: Product.fromOrderMap(map),
        quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      );

  String toJson() => json.encode(toMap());

  factory ProductQuantity.fromJson(String source) =>
      ProductQuantity.fromMap(json.decode(source) as Map<String, dynamic>);
}
