// To parse this JSON data, do
//
//     final friendChat = friendChatFromJson(jsonString);

import 'dart:convert';

List<FriendChat> friendChatFromJson(String str) => List<FriendChat>.from(json.decode(str).map((x) => FriendChat.fromJson(x)));

String friendChatToJson(List<FriendChat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FriendChat {
    FriendChat({
        required this.dateTime,
        required this.tx,
        required this.rx,
        required this.message,
    });

    DateTime dateTime;
    String tx;
    String rx;
    String message;

    factory FriendChat.fromJson(Map<String, dynamic> json) => FriendChat(
        dateTime: DateTime.parse(json["DateTime"]),
        tx: json["Tx"],
        rx: json["Rx"],
        message: json["Message"],
    );

    Map<String, dynamic> toJson() => {
        "DateTime": dateTime.toIso8601String(),
        "Tx": tx,
        "Rx": rx,
        "Message": message,
    };
}
