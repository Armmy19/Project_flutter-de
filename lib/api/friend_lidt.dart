// To parse this JSON data, do
//
//     final chatFriendList = chatFriendListFromJson(jsonString);

import 'dart:convert';

List<ChatFriendList> chatFriendListFromJson(String str) => List<ChatFriendList>.from(json.decode(str).map((x) => ChatFriendList.fromJson(x)));

String chatFriendListToJson(List<ChatFriendList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatFriendList {
    ChatFriendList({
        required this.id,
        required this.name,
        required this.lastname,
    });

    String id;
    String name;
    String lastname;

    factory ChatFriendList.fromJson(Map<String, dynamic> json) => ChatFriendList(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
    };
}
