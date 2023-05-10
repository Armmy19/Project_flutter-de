// // To parse required this JSON data, do
// //
// //     final youaddress = youaddressFromJson(jsonString);

// import 'dart:convert';

// Youaddress youaddressFromJson(String str) => Youaddress.fromJson(json.decode(str));

// String youaddressToJson(Youaddress data) => json.encode(data.toJson());

// class Youaddress {
//     Youaddress({
//         required this.status,
//         required this.message,
//     });

//     String status;
//     Message message;

//     factory Youaddress.fromJson(Map<String, dynamic> json) => Youaddress(
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
//         required this.userHouseNum,
//         required this.userVillageNum,
//         required this.userAlleylane,
//         required this.userRoad,
//         required this.userSubdistrict,
//         required this.userDistrict,
//         required this.userProvince,
//         required this.userPostalcode,
//     });

//     String userHouseNum;
//     String userVillageNum;
//     String userAlleylane;
//     String userRoad;
//     String userSubdistrict;
//     String userDistrict;
//     String userProvince;
//     String userPostalcode;

//     factory Message.fromJson(Map<String, dynamic> json) => Message(
//         userHouseNum: json["user_houseNum"],
//         userVillageNum: json["user_villageNum"],
//         userAlleylane: json["user_alleylane"],
//         userRoad: json["user_road"],
//         userSubdistrict: json["user_subdistrict"],
//         userDistrict: json["user_district"],
//         userProvince: json["user_province"],
//         userPostalcode: json["user_postalcode"],
//     );

//     Map<String, dynamic> toJson() => {
//         "user_houseNum": userHouseNum,
//         "user_villageNum": userVillageNum,
//         "user_alleylane": userAlleylane,
//         "user_road": userRoad,
//         "user_subdistrict": userSubdistrict,
//         "user_district": userDistrict,
//         "user_province": userProvince,
//         "user_postalcode": userPostalcode,
//     };
// }


// To parse this JSON data, do
//
//     final youaddress = youaddressFromJson(jsonString);

import 'dart:convert';
import 'dart:async';

Youaddress youaddressFromJson(String str) => Youaddress.fromJson(json.decode(str));

String youaddressToJson(Youaddress data) => json.encode(data.toJson());

class Youaddress {
    Youaddress({
        required this.status,
        required this.message,
    });

    String status;
    Message message;

    factory Youaddress.fromJson(Map<String, dynamic> json) => Youaddress(
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
        this.userHouseNum,
        this.userVillageNum,
        this.userAlleylane,
        this.userRoad,
        this.userSubdistrict,
        this.userDistrict,
        this.userProvince,
        this.userPostalcode,
    });

    dynamic userHouseNum;
    dynamic userVillageNum;
    dynamic userAlleylane;
    dynamic userRoad;
    dynamic userSubdistrict;
    dynamic userDistrict;
    dynamic userProvince;
    dynamic userPostalcode;

    

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        userHouseNum: json["user_houseNum"],
        userVillageNum: json["user_villageNum"],
        userAlleylane: json["user_alleylane"],
        userRoad: json["user_road"],
        userSubdistrict: json["user_subdistrict"],
        userDistrict: json["user_district"],
        userProvince: json["user_province"],
        userPostalcode: json["user_postalcode"],
    );

    Map<String, dynamic> toJson() => {
        "user_houseNum": userHouseNum,
        "user_villageNum": userVillageNum,
        "user_alleylane": userAlleylane,
        "user_road": userRoad,
        "user_subdistrict": userSubdistrict,
        "user_district": userDistrict,
        "user_province": userProvince,
        "user_postalcode": userPostalcode,
    };
}
