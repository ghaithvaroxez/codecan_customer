class User {
  int id;

  String name;
  String email;
  String phone;
  String photo;
  String role;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'] ?? "";
    role = json['role_name'] ?? "client";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'role_name': role,
    };
  }
}
