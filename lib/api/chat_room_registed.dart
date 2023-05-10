// To parse this JSON data, do
//
//     final chatRoomRegisted = chatRoomRegistedFromJson(jsonString);

import 'dart:convert';

List<ChatRoomRegisted> chatRoomRegistedFromJson(String str) => List<ChatRoomRegisted>.from(json.decode(str).map((x) => ChatRoomRegisted.fromJson(x)));

String chatRoomRegistedToJson(List<ChatRoomRegisted> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatRoomRegisted {
    ChatRoomRegisted({
        required this.id,
        required this.room,
        required this.title,
        required this.detail,
        required this.datetime,
        required this.chatRoomRegistedClass,
        required this.name,
        required this.status,
        required this.member,
    });

    String id;
    String room;
    String title;
    String detail;
    DateTime datetime;
    String chatRoomRegistedClass;
    String name;
    String status;
    String member;

    factory ChatRoomRegisted.fromJson(Map<String, dynamic> json) => ChatRoomRegisted(
        id: json["id"],
        room: json["room"],
        title: json["title"],
        detail: json["detail"],
        datetime: DateTime.parse(json["datetime"]),
        chatRoomRegistedClass: json["class"],
        name: json["name"],
        status: json["status"],
        member: json["member"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "room": room,
        "title": title,
        "detail": detail,
        "datetime": datetime.toIso8601String(),
        "class": chatRoomRegistedClass,
        "name": name,
        "status": status,
        "member": member,
    };
}
