import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyMessage {
  String content;
  String messageId = '';
  String senderName;
  String senderImage;
  String senderId;
  String roomId;
  int dateTime;
  MyMessage({
    required this.content,
    required this.messageId,
    required this.senderName,
    required this.senderImage,
    required this.senderId,
    required this.roomId,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'messageId': messageId,
      'senderName': senderName,
      'senderImage': senderImage,
      'senderId': senderId,
      'roomId': roomId,
      'dateTime': dateTime,
    };
  }

  factory MyMessage.fromMap(Map<String, dynamic> map) {
    return MyMessage(
      content: map['content'] as String,
      messageId: map['messageId'] as String,
      senderName: map['senderName'] as String,
      senderImage: map['senderImage'] as String,
      senderId: map['senderId'] as String,
      roomId: map['roomId'] as String,
      dateTime: map['dateTime'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyMessage.fromJson(String source) =>
      MyMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  MyMessage copyWith({
    String? content,
    String? messageId,
    String? senderName,
    String? senderImage,
    String? senderId,
    String? roomId,
    int? dateTime,
  }) {
    return MyMessage(
      content: content ?? this.content,
      messageId: messageId ?? this.messageId,
      senderName: senderName ?? this.senderName,
      senderImage: senderImage ?? this.senderImage,
      senderId: senderId ?? this.senderId,
      roomId: roomId ?? this.roomId,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  String toString() {
    return 'MyMessage(content: $content, messageId: $messageId, senderName: $senderName,senderImage:$senderImage, senderId: $senderId, roomId: $roomId, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant MyMessage other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.messageId == messageId &&
        other.senderName == senderName &&
        other.senderImage == senderImage &&
        other.senderId == senderId &&
        other.roomId == roomId &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        messageId.hashCode ^
        senderName.hashCode ^
        senderImage.hashCode ^
        senderId.hashCode ^
        roomId.hashCode ^
        dateTime.hashCode;
  }
}
