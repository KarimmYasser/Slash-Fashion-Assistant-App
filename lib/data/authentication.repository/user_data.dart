class UserData {
  UserData(Map<String, dynamic> data) {
    id = data['id'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    username = data['username'];
    gender = data['gender'];
    age = data['age'];
    email = data['email'];
    password = data['password'];
    phone = data['phone'];
    image = data['image'];
    city = data['city'];
    preferences = data['preferences'];
  }
  static UserData? userData;
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? gender;
  int? age;
  String? email;
  String? password;
  String? phone;
  String? image;
  String? city;
  Map<String, dynamic>? preferences;
}
