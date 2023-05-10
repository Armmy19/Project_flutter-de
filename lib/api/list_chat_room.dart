// To parse this JSON data, do
//
//     final listChatRoom = listChatRoomFromJson(jsonString);

import 'dart:convert';

List<ListChatRoom> listChatRoomFromJson(String str) => List<ListChatRoom>.from(json.decode(str).map((x) => ListChatRoom.fromJson(x)));

String listChatRoomToJson(List<ListChatRoom> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListChatRoom {
    ListChatRoom({
        required this.id,
        required this.room,
        required this.title,
        required this.detail,
        required this.datetime,
        required this.listChatRoomClass,
        required this.name,
        required this.status,
        required this.member,
    });

    String id;
    String room;
    String title;
    String detail;
    DateTime datetime;
    String listChatRoomClass;
    String name;
    dynamic status;
    String member;

    factory ListChatRoom.fromJson(Map<String, dynamic> json) => ListChatRoom(
        id: json["id"],
        room: json["room"],
        title: json["title"],
        detail: json["detail"],
        datetime: DateTime.parse(json["datetime"]),
        listChatRoomClass: json["class"],
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
        "class": listChatRoomClass,
        "name": name,
        "status": status,
        "member": member,
    };
}
