// To parse this JSON data, do
//
//     final loginuser = loginuserFromJson(jsonString);

import 'dart:convert';

Loginuser loginuserFromJson(String str) => Loginuser.fromJson(json.decode(str));

String loginuserToJson(Loginuser data) => json.encode(data.toJson());

class Loginuser {
    Loginuser({
        required this.status,
        required this.message,
    });

    String status;
    Message message;

    factory Loginuser.fromJson(Map<String, dynamic> json) => Loginuser(
        status: json["status"],
        message: Message.fromJson(json["Message"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message.toJson(),
    };
}

class Message {
    Message({
        required this.id,
        required this.userClass,
        required this.userIdcard,
        required this.userTitlename,
        required this.userName,
        required this.userLastname,
        required this.userUsername,
        required this.userPassword,
        required this.userGender,
        required this.userBirthday,
        required this.userPhone,
        required this.userEmail,
        required this.userLatitude,
        required this.userLongitude,
        required this.userHouseNum,
        required this.userVillageNum,
        required this.userAlleylane,
        required this.userRoad,
        required this.userSubdistrict,
        required this.userDistrict,
        required this.userProvince,
        required this.userPostalcode,
        required this.userStatus,
        required this.userToken,
    });

    String id;
    String userClass;
    dynamic userIdcard;
    String userTitlename;
    String userName;
    String userLastname;
    String userUsername;
    String userPassword;
    dynamic userGender;
    dynamic userBirthday;
    dynamic userPhone;
    String userEmail;
    dynamic userLatitude;
    dynamic userLongitude;
    dynamic userHouseNum;
    dynamic userVillageNum;
    dynamic userAlleylane;
    dynamic userRoad;
    dynamic userSubdistrict;
    dynamic userDistrict;
    dynamic userProvince;
    dynamic userPostalcode;
    String userStatus;
    dynamic userToken;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        userClass: json["user_class"],
        userIdcard: json["user_idcard"],
        userTitlename: json["user_titlename"],
        userName: json["user_name"],
        userLastname: json["user_lastname"],
        userUsername: json["user_username"],
        userPassword: json["user_password"],
        userGender: json["user_gender"],
        userBirthday: json["user_birthday"],
        userPhone: json["user_phone"],
        userEmail: json["user_email"],
        userLatitude: json["user_latitude"],
        userLongitude: json["user_longitude"],
        userHouseNum: json["user_houseNum"],
        userVillageNum: json["user_villageNum"],
        userAlleylane: json["user_alleylane"],
        userRoad: json["user_road"],
        userSubdistrict: json["user_subdistrict"],
        userDistrict: json["user_district"],
        userProvince: json["user_province"],
        userPostalcode: json["user_postalcode"],
        userStatus: json["user_status"],
        userToken: json["user_token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_class": userClass,
        "user_idcard": userIdcard,
        "user_titlename": userTitlename,
        "user_name": userName,
        "user_lastname": userLastname,
        "user_username": userUsername,
        "user_password": userPassword,
        "user_gender": userGender,
        "user_birthday": userBirthday,
        "user_phone": userPhone,
        "user_email": userEmail,
        "user_latitude": userLatitude,
        "user_longitude": userLongitude,
        "user_houseNum": userHouseNum,
        "user_villageNum": userVillageNum,
        "user_alleylane": userAlleylane,
        "user_road": userRoad,
        "user_subdistrict": userSubdistrict,
        "user_district": userDistrict,
        "user_province": userProvince,
        "user_postalcode": userPostalcode,
        "user_status": userStatus,
        "user_token": userToken,
    };
}
