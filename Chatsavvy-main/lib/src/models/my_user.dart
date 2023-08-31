import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyUser {
  static MyUser? currentUser;
  late String id;
  late String name;
  late String email;
  late String image;
  late String phone;
  MyUser({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
  });

  toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'phone': phone,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
