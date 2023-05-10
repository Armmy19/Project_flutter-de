// To parse this JSON data, do
//
//     final chatMemberRequest = chatMemberRequestFromJson(jsonString);

import 'dart:convert';

List<ChatMemberRequest> chatMemberRequestFromJson(String str) => List<ChatMemberRequest>.from(json.decode(str).map((x) => ChatMemberRequest.fromJson(x)));

String chatMemberRequestToJson(List<ChatMemberRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatMemberRequest {
    ChatMemberRequest({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory ChatMemberRequest.fromJson(Map<String, dynamic> json) => ChatMemberRequest(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
