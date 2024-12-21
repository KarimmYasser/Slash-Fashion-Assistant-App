class Review {
  final String id;
  final String userId;
  final String productId;
  final double rating;
  final double valueForMoneyRate;
  final double qualityRate;
  final double shippingRate;
  final double accuracyRate;
  final String image;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likes;
  final bool liked;
  final String firstname, lastname;
  Review({
    required this.firstname,
    required this.lastname,
    required this.likes,
    required this.image,
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    required this.valueForMoneyRate,
    required this.qualityRate,
    required this.shippingRate,
    required this.accuracyRate,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.liked,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      liked: json['liked'] ?? false,
      image: json['image'] ?? '',
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      productId: json['product_id'] ?? '',
      rating: (json['rating'] as num).toDouble(),
      valueForMoneyRate: (json['valueForMoney_rate'] as num).toDouble(),
      qualityRate: (json['quality_rate'] as num).toDouble(),
      shippingRate: (json['shipping_rate'] as num).toDouble(),
      accuracyRate: (json['accuracy_rate'] as num).toDouble(),
      comment: json['comment'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      likes: json['likes'] ?? 0,
      firstname: json['user']['firstName'] ?? '',
      lastname: json['user']['lastName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'rating': rating,
      'valueForMoney_rate': valueForMoneyRate,
      'quality_rate': qualityRate,
      'shipping_rate': shippingRate,
      'accuracy_rate': accuracyRate,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
