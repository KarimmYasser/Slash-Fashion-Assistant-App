class ProductCardModel {
  final String id;
  final String brandId;
  final String categoryId;
  final String name;
  final double price;
  final String? description;
  final int discount;
  final double rating;
  final bool ratedStatus;
  final String material;
  final int returnPeriod;
  final bool inStock;
  final String image;
  final DateTime createdAt;
  final bool isInWishlist;

  ProductCardModel({
    required this.id,
    required this.brandId,
    required this.categoryId,
    required this.name,
    required this.price,
    this.description,
    required this.discount,
    required this.rating,
    required this.ratedStatus,
    required this.material,
    required this.returnPeriod,
    required this.inStock,
    required this.image,
    required this.createdAt,
    required this.isInWishlist,
  });

  factory ProductCardModel.fromJson(Map<String, dynamic> json) {
    return ProductCardModel(
      id: json['id'] ?? '',
      brandId: json['brand_id'] ?? '',
      categoryId: json['category_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'],
      discount: json['discount'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      ratedStatus: json['rated_status'] ?? false,
      material: json['material'] ?? '',
      returnPeriod: json['returnPeriod'] ?? 0,
      inStock: json['inStock'] ?? false,
      image: json['image'] ?? '',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      isInWishlist: json['isInWishlist'] ?? true,
    );
  }
}
