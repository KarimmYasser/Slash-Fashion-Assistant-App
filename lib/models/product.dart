class Product {
  final String brandShowcase;
  final double prevprice;
  final String id;
  final String brandID;
  final bool inStock;
  final String image;
  final String categoryID;
  final String createdAt;
  final String sizes;
  final String colors;
  final String reviews;
  final bool isInWishlist;
  Product({
    required this.isInWishlist,
    required this.id,
    required this.brandID,
    required this.inStock,
    required this.image,
    required this.categoryID,
    required this.createdAt,
    required this.sizes,
    required this.colors,
    required this.reviews,
    required this.brandShowcase,
    required this.prevprice,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        brandShowcase: json['name'] ?? '',
        prevprice: (json['price'] as num).toDouble(),
        id: json['id'] ?? '',
        brandID: json['brand_id'] ?? '',
        inStock: json['inStock'] ?? true,
        image: json['image'] ?? '',
        categoryID: json['category_id'] ?? '',
        createdAt: json['created_at'] ?? '',
        sizes: json['sizes'] ?? '',
        colors: json['colours'] ?? '',
        reviews: json['reviews'] ?? '',
        isInWishlist: json['isInWishlist'] ?? false);
  }
}
