class Brand {
  final String id;
  final String name;
  final String email;
  final double rating;
  final String phone;
  final String description;
  final String logo;
  final String facebook;
  final String instagram;
  final String website;
  final String createdAt;
  final String updatedAt;
  bool isFollowed;

  Brand({
    required this.isFollowed,
    required this.id,
    required this.name,
    required this.email,
    required this.rating,
    required this.phone,
    required this.description,
    required this.logo,
    required this.facebook,
    required this.instagram,
    required this.website,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      isFollowed: json['followed'] ?? false,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      rating: ((json['rating'] ?? 0) as num).toDouble(),
      phone: json['phone'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      facebook: json['facebook'] ?? '',
      instagram: json['instagram'] ?? '',
      website: json['website'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class BrandsResponse {
  final List<Brand> brands;

  BrandsResponse({required this.brands});

  factory BrandsResponse.fromJson(Map<String, dynamic> json) {
    return BrandsResponse(
      brands: List<Brand>.from(
        json['brands'].map((brandJson) => Brand.fromJson(brandJson)),
      ),
    );
  }
}
