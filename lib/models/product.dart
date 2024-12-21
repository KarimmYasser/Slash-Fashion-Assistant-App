class Product {
  final String id;
  final String brandID;
  final String categoryID;
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
  final String createdAt;
  final List<Size> sizes;
  final Map<String, String> colours;
  final List<dynamic> diffColours;
  final bool isInWishlist;
  final Brand brand;
  final Category category;
  final List<Variant> variants;
  bool isFollowing;
  Product({
    required this.isFollowing,
    required this.id,
    required this.brandID,
    required this.categoryID,
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
    required this.sizes,
    required this.colours,
    required this.diffColours,
    required this.isInWishlist,
    required this.brand,
    required this.category,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      isFollowing: json['followedBrand'] ?? false,
      id: json['id'] ?? '',
      brandID: json['brand_id'] ?? '',
      categoryID: json['category_id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] != null
          ? (json['price'] is int
              ? (json['price'] as int).toDouble()
              : json['price'])
          : 0.0,
      description: json['description'],
      discount: json['discount'] ?? 0,
      rating: json['rating'] != null
          ? (json['rating'] is int
              ? (json['rating'] as int).toDouble()
              : json['rating'])
          : 0.0,
      ratedStatus: json['rated_status'] ?? false,
      material: json['material'] ?? '',
      returnPeriod: json['returnPeriod'] ?? 0,
      inStock: json['inStock'] ?? true,
      image: json['image'] ?? '',
      createdAt: json['created_at'] ?? '',
      sizes: (json['sizes'] as List<dynamic>?)
              ?.map((sizeJson) => Size.fromJson(sizeJson))
              .toList() ??
          [],
      colours:
          json['colours'] != null && json['colours'] is Map<String, dynamic>
              ? Map<String, String>.from(json['colours'])
              : {},
      diffColours: json['diffColours'] ?? [],
      isInWishlist: json['isInWishlist'] ?? false,
      brand: Brand.fromJson(json['brand']),
      category: Category.fromJson(json['category']),
      variants: (json['variants'] as List<dynamic>?)
              ?.map((variantJson) => Variant.fromJson(variantJson))
              .toList() ??
          [],
    );
  }
}

class Brand {
  final String id;
  final String userID;
  final String name;
  final double rating;
  final bool ratedStatus;
  final String phone;
  final String description;
  final String? logo;
  final String facebook;
  final String instagram;
  final String website;

  Brand({
    required this.id,
    required this.userID,
    required this.name,
    required this.rating,
    required this.ratedStatus,
    required this.phone,
    required this.description,
    this.logo,
    required this.facebook,
    required this.instagram,
    required this.website,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] ?? '',
      userID: json['user_id'] ?? '',
      name: json['name'] ?? '',
      rating: (json['rating'] as num).toDouble(),
      ratedStatus: json['rated_status'] ?? false,
      phone: json['phone'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'],
      facebook: json['facebook'] ?? '',
      instagram: json['instagram'] ?? '',
      website: json['website'] ?? '',
    );
  }
}

class Category {
  final String id;
  final String name;
  final String style;

  Category({
    required this.id,
    required this.name,
    required this.style,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      style: json['style'] ?? '',
    );
  }
}

class Variant {
  final String size;
  final int quantity;
  final String productVariantId;

  Variant({
    required this.size,
    required this.quantity,
    required this.productVariantId,
  });

  factory Variant.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('json cannot be null');
    }
    return Variant(
      size: json['size'] ?? '',
      quantity: json['quantity'] ?? 0,
      productVariantId: json['productVariantId'] ?? '',
    );
  }
}

class Size {
  final String id;
  final String brandID;
  final String categoryID;
  final String size;
  final int? waist;
  final int length;
  final int chest;
  final int armLength;
  final int bicep;
  final int? footLength;

  Size({
    required this.id,
    required this.brandID,
    required this.categoryID,
    required this.size,
    this.waist,
    required this.length,
    required this.chest,
    required this.armLength,
    required this.bicep,
    this.footLength,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['id'] ?? '',
      brandID: json['brand_id'] ?? '',
      categoryID: json['category_id'] ?? '',
      size: json['size'] ?? '',
      waist: json['waist'] ?? 0,
      length: json['length'] ?? 0,
      chest: json['chest'] ?? 0,
      armLength: json['arm_length'] ?? 0,
      bicep: json['bicep'] ?? 0,
      footLength: json['foot_length'] ?? 0,
    );
  }
}
