// // To parse this JSON data, do
// //
// //     final profileShow = profileShowFromJson(jsonString);

// import 'dart:convert';

// ProfileShow profileShowFromJson(String str) => ProfileShow.fromJson(json.decode(str));

// String profileShowToJson(ProfileShow data) => json.encode(data.toJson());

// class ProfileShow {
//     ProfileShow({
//         required this.status,
//         required this.message,
//     });

//     String status;
//     Message message;

//     factory ProfileShow.fromJson(Map<String, dynamic> json) => ProfileShow(
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
//         required this.userClass,
//         required this.userTitlename,
//         required this.userName,
//         required this.userLastname,
//         required this.userPhone,
//         required this.userUser,
//         required this.userEmail,
//         required this.userGender,
//         required this.userBirthday,
//         required this.profileImg,
//     });

//     String userClass;
//     String userTitlename;
//     String userName;
//     String userLastname;
//     String userPhone;
//     String userUser;
//     String userEmail;
//     String userGender;
//     String userBirthday;
//     String profileImg;

//     factory Message.fromJson(Map<String, dynamic> json) => Message(
//         userClass: json["user_class"],
//         userTitlename: json["user_titlename"],
//         userName: json["user_name"],
//         userLastname: json["user_lastname"],
//         userPhone: json["user_phone"],
//         userUser: json["user_user"],
//         userEmail: json["user_email"],
//         userGender: json["user_gender"],
//         userBirthday: json["user_birthday"],
//         profileImg: json["profile_img"],
//     );

//     Map<String, dynamic> toJson() => {
//         "user_class": userClass,
//         "user_titlename": userTitlename,
//         "user_name": userName,
//         "user_lastname": userLastname,
//         "user_phone": userPhone,
//         "user_user": userUser,
//         "user_email": userEmail,
//         "user_gender": userGender,
//         "user_birthday": userBirthday,
//         "profile_img": profileImg,
//     };
// }

// To parse this JSON data, do
//
//     final profileShow = profileShowFromJson(jsonString);

// import 'dart:convert';

// ProfileShow profileShowFromJson(String str) => ProfileShow.fromJson(json.decode(str));

// String profileShowToJson(ProfileShow data) => json.encode(data.toJson());

// class ProfileShow {
//     ProfileShow({
//         required this.status,
//         required this.message,
//     });

//     String status;
//     Message message;

//     factory ProfileShow.fromJson(Map<String, dynamic> json) => ProfileShow(
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
//         required this.userClass,
//         required this.userTitlename,
//         required this.userName,
//         required this.userLastname,
//         required this.userPhone,
//         required this.userUser,
//         required this.userEmail,
//         required this.userGender,
//         required this.userBirthday,
//         required this.profileImg,
//     });

//     String userClass;
//     String userTitlename;
//     String userName;
//     String userLastname;
//     dynamic userPhone;
//     String userUser;
//     String userEmail;
//     dynamic userGender;
//     dynamic userBirthday;
//     String profileImg;

//     factory Message.fromJson(Map<String, dynamic> json) => Message(
//         userClass: json["user_class"],
//         userTitlename: json["user_titlename"],
//         userName: json["user_name"],
//         userLastname: json["user_lastname"],
//         userPhone: json["user_phone"],
//         userUser: json["user_user"],
//         userEmail: json["user_email"],
//         userGender: json["user_gender"],
//         userBirthday: json["user_birthday"],
//         profileImg: json["profile_img"],
//     );

//     Map<String, dynamic> toJson() => {
//         "user_class": userClass,
//         "user_titlename": userTitlename,
//         "user_name": userName,
//         "user_lastname": userLastname,
//         "user_phone": userPhone,
//         "user_user": userUser,
//         "user_email": userEmail,
//         "user_gender": userGender,
//         "user_birthday": userBirthday,
//         "profile_img": profileImg,
//     };
// }

// To parse this JSON data, do
//
//     final profileShow = profileShowFromJson(jsonString);

import 'dart:convert';

ProfileShow profileShowFromJson(String str) =>
    ProfileShow.fromJson(json.decode(str));

String profileShowToJson(ProfileShow data) => json.encode(data.toJson());

class ProfileShow {
  ProfileShow({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory ProfileShow.fromJson(Map<String, dynamic> json) => ProfileShow(
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
    required this.userClass,
    required this.userTitlename,
    required this.userName,
    required this.userLastname,
    required this.userPhone,
    required this.userUser,
    required this.userEmail,
    required this.userGender,
    required this.profileImg,
    required this.userBirthday,
  });

  String userClass;
  String userTitlename;
  String userName;
  String userLastname;
  dynamic userPhone;
  String userUser;
  String userEmail;
  dynamic userBirthday;
  dynamic userGender;
  dynamic profileImg;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        userClass: json["user_class"],
        userTitlename: json["user_titlename"],
        userName: json["user_name"],
        userLastname: json["user_lastname"],
        userPhone: json["user_phone"],
        userUser: json["user_user"],
        userEmail: json["user_email"],
        userGender: json["user_gender"],
        profileImg: json["profile_img"],
        userBirthday: json["user_birthday"],
      );

  Map<String, dynamic> toJson() => {
        "user_class": userClass,
        "user_titlename": userTitlename,
        "user_name": userName,
        "user_lastname": userLastname,
        "user_phone": userPhone,
        "user_user": userUser,
        "user_email": userEmail,
        "user_gender": userGender,
        "profile_img": profileImg,
        "user_birthday": userBirthday,
      };
}
