import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.addedAt,
  });

  final String productId;
  final String userId;
  final int quantity;
  final DateTime addedAt;

  @override
  List<Object> get props => [productId, userId, quantity, addedAt];

  @override
  bool? get stringify => true;

  CartItem copyWith({
    String? productId,
    String? userId,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'userId': userId,
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] as String,
      userId: json['userId'] as String,
      quantity: json['quantity'] as int,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }
}
