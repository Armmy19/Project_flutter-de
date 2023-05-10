// To parse this JSON data, do
//
//     final chatMessage = chatMessageFromJson(jsonString);

import 'dart:convert';

List<ChatMessage> chatMessageFromJson(String str) => List<ChatMessage>.from(json.decode(str).map((x) => ChatMessage.fromJson(x)));

String chatMessageToJson(List<ChatMessage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatMessage {
    ChatMessage({
        required this.id,
        required this.senderId,
        required this.sender,
        this.toId,
        required this.to,
        required this.message,
        required this.datetime,
    });

    String id;
    String senderId;
    String sender;
    dynamic toId;
    String to;
    String message;
    DateTime datetime;

    factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json["id"],
        senderId: json["SenderID"],
        sender: json["Sender"],
        toId: json["ToID"],
        to: json["To"],
        message: json["message"],
        datetime: DateTime.parse(json["datetime"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "SenderID": senderId,
        "Sender": sender,
        "ToID": toId,
        "To": to,
        "message": message,
        "datetime": datetime.toIso8601String(),
    };
}
