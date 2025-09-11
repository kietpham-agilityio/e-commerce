import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  const Favorite({
    required this.productId,
    required this.userId,
    required this.addedAt,
  });

  final String productId;
  final String userId;
  final DateTime addedAt;

  @override
  List<Object> get props => [productId, userId, addedAt];

  @override
  bool? get stringify => true;

  Favorite copyWith({String? productId, String? userId, DateTime? addedAt}) {
    return Favorite(
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'userId': userId,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      productId: json['productId'] as String,
      userId: json['userId'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }
}
