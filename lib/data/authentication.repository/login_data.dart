class UserData {
  UserData(Map<String, dynamic> data) {
    id = data['id'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    username = data['username'];
    age = data['age'];
    gender = data['gender'];
    phone = data['phone'];
    image = data['image'];
    city = data['city'];
    preferences = data['preferences'];
    email = data['email'];
  }
  static UserData? userData;
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? gender;
  int? age;
  String? email;
  String? phone;
  String? image;
  String? city;
  Map<String, dynamic>? preferences;
}

class BrandData {
  BrandData(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    rating = data['rating'];
    ratedStatus = data['rated_status'];
    phone = data['phone'];
    email = data['email'];
    description = data['description'];
    logo = data['logo'];
  }
  static BrandData? brandData;
  String? id;
  String? name;
  double? rating;
  bool? ratedStatus;
  String? phone;
  String? email;
  String? description;
  String? logo;
}

class AdminData {
  AdminData(Map<String, dynamic> data) {
    id = data['id'];
    username = data['username'];
    role = data['role'];
    email = data['email'];
  }
  static AdminData? adminData;
  String? id;
  String? username;
  String? role;
  String? email;
}
