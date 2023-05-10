// // To parse this JSON data, do
// //
// //     final chatbot = chatbotFromJson(jsonString);

// import 'dart:convert';

// Chatbot chatbotFromJson(String str) => Chatbot.fromJson(json.decode(str));

// String chatbotToJson(Chatbot data) => json.encode(data.toJson());

// class Chatbot {
//     Chatbot({
//         required this.status,
//         required this.message,
//     });

//     String status;
//     Message message;

//     factory Chatbot.fromJson(Map<String, dynamic> json) => Chatbot(
//         status: json["status"],
//         message: Message.fromJson(json["message"]),
//     );

//   get isEmpty => null;

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message.toJson(),
//     };
// }

// class Message {
//     Message({
//         required this.replies,
//         required this.link,
//     });

//     String replies;
//     String link;

//     factory Message.fromJson(Map<String, dynamic> json) => Message(
//         replies: json["replies"],
//         link: json["link"],
//     );

//     Map<String, dynamic> toJson() => {
//         "replies": replies,
//         "link": link,
//     };
// }

// To parse this JSON data, do
//
//     final chatbot = chatbotFromJson(jsonString);

import 'dart:convert';

Chatbot chatbotFromJson(String str) => Chatbot.fromJson(json.decode(str));

String chatbotToJson(Chatbot data) => json.encode(data.toJson());

class Chatbot {
  Chatbot({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory Chatbot.fromJson(Map<String, dynamic> json) => Chatbot(
        status: json["status"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.replies,
    required this.link,
  });

  String replies;
  String link;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        replies: json["replies"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "replies": replies,
        "link": link,
      };
}
