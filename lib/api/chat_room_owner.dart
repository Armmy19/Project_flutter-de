// To parse this JSON data, do
//
//     final chatRoomOwner = chatRoomOwnerFromJson(jsonString);

import 'dart:convert';

List<ChatRoomOwner> chatRoomOwnerFromJson(String str) => List<ChatRoomOwner>.from(json.decode(str).map((x) => ChatRoomOwner.fromJson(x)));

String chatRoomOwnerToJson(List<ChatRoomOwner> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatRoomOwner {
    ChatRoomOwner({
        required this.id,
        required this.room,
        required this.title,
        required this.detail,
        required this.datetime,
        required this.chatRoomOwnerClass,
        required this.name,
        required this.member,
    });

    String id;
    String room;
    String title;
    String detail;
    DateTime datetime;
    String chatRoomOwnerClass;
    String name;
    String member;

    factory ChatRoomOwner.fromJson(Map<String, dynamic> json) => ChatRoomOwner(
        id: json["id"],
        room: json["room"],
        title: json["title"],
        detail: json["detail"],
        datetime: DateTime.parse(json["datetime"]),
        chatRoomOwnerClass: json["class"],
        name: json["name"],
        member: json["member"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "room": room,
        "title": title,
        "detail": detail,
        "datetime": datetime.toIso8601String(),
        "class": chatRoomOwnerClass,
        "name": name,
        "member": member,
    };
}
