import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyUser {
  static MyUser? currentUser;
  String id;
  String name;
  String email;
  String imageUrl;
  String phone;
  MyUser({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'phone': phone,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
