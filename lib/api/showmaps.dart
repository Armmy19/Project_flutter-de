// // To parse required this JSON data, do
// //
// //     final youmaps = youmapsFromJson(jsonString);

// import 'dart:convert';

// Youmaps youmapsFromJson(String str) => Youmaps.fromJson(json.decode(str));

// String youmapsToJson(Youmaps data) => json.encode(data.toJson());

// class Youmaps {
//     Youmaps({
//         required this.status,
//         required this.message,
//     });

//     String status;
//     Message message;

//     factory Youmaps.fromJson(Map<String, dynamic> json) => Youmaps(
//         status: json["status"],
//         message: Message.fromJson(json["message"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message.toJson(),
//     };
// }

// class Message {
//     Message({
//         required this.latitude,
//         required this.longitude,
//     });

//     String latitude;
//     String longitude;

//     factory Message.fromJson(Map<String, dynamic> json) => Message(
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//     );

//     Map<String, dynamic> toJson() => {
//         "latitude": latitude,
//         "longitude": longitude,
//     };
// }



// To parse this JSON data, do
//
//     final youmaps = youmapsFromJson(jsonString);

import 'dart:convert';

Youmaps youmapsFromJson(String str) => Youmaps.fromJson(json.decode(str));

String youmapsToJson(Youmaps data) => json.encode(data.toJson());

class Youmaps {
    Youmaps({
        required this.status,
        required this.message,
    });

    String status;
    Message message;

    factory Youmaps.fromJson(Map<String, dynamic> json) => Youmaps(
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
        this.latitude,
        this.longitude,
    });

    dynamic latitude;
    dynamic longitude;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
