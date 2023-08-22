import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyRoom {
  String name;
  String description;
  String roomId;
  MyRoom({
    required this.name,
    required this.description,
    required this.roomId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'roomId': roomId,
    };
  }

  factory MyRoom.fromMap(Map<String, dynamic> map) {
    return MyRoom(
      name: map['name'] as String,
      description: map['description'] as String,
      roomId: map['roomId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRoom.fromJson(String source) =>
      MyRoom.fromMap(json.decode(source) as Map<String, dynamic>);
}
