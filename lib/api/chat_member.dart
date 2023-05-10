// To parse this JSON data, do
//
//     final chatMember = chatMemberFromJson(jsonString);

import 'dart:convert';

List<ChatMember> chatMemberFromJson(String str) => List<ChatMember>.from(json.decode(str).map((x) => ChatMember.fromJson(x)));

String chatMemberToJson(List<ChatMember> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatMember {
    ChatMember({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory ChatMember.fromJson(Map<String, dynamic> json) => ChatMember(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
