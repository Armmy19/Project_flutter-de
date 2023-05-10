// To parse this JSON data, do
//
//     final dataresume = dataresumeFromJson(jsonString);

import 'dart:convert';
import '../job/resume_mapper.dart';

Dataresume dataresumeFromJson(String str) =>
    Dataresume.fromJson(json.decode(str));

String dataresumeToJson(Dataresume data) => json.encode(data.toJson());

class Dataresume {
  Dataresume({
    required this.status,
    required this.message,
  });

  String status;
  Message message;

  factory Dataresume.fromJson(Map<String, dynamic> json) => Dataresume(
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
    required this.id,
    required this.userTitlename,
    required this.userName,
    required this.userLastname,
    required this.userClass,
    this.userGender,
    this.userPhone,
    required this.userEmail,
    required this.profileImg,
    this.userLatitude,
    this.userLongitude,
    this.userHouseNum,
    this.userVillageNum,
    this.userAlleylane,
    this.userRoad,
    this.userSubdistrict,
    this.userDistrict,
    this.userProvince,
    this.userPostalcode,
    this.resumeGraduation,
    this.resumeEducationalPlace,
    this.resumeJobTypeInterested,
    this.resumeRequiredSalary,
    this.resumeLanguageAbility,
    this.resumeComputerSkills,
    this.resumeHistoryWork,
    this.resumeTraining,
    this.resumeAwarded,
  });

  String id;
  String userTitlename;
  String userName;
  String userLastname;
  String userClass;
  dynamic userGender;
  dynamic userPhone;
  String userEmail;
  String profileImg;
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
  dynamic resumeGraduation;
  dynamic resumeEducationalPlace;
  dynamic resumeJobTypeInterested;
  dynamic resumeRequiredSalary;
  dynamic resumeLanguageAbility;
  dynamic resumeComputerSkills;
  dynamic resumeHistoryWork;
  dynamic resumeTraining;
  dynamic resumeAwarded;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        userTitlename: json["user_titlename"],
        userName: json["user_name"],
        userLastname: json["user_lastname"],
        userClass: json["user_class"],
        userGender: json["user_gender"],
        userPhone: json["user_phone"],
        userEmail: json["user_email"],
        profileImg: json["profile_img"],
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
        resumeGraduation:
            graduation_maper_reverse(json["resume_graduation"] ?? ''),
        resumeEducationalPlace: json["resume_educational_place"],
        resumeJobTypeInterested: type_interested_maper_reverse(
            json["resume_job_type_interested"] ?? ''),
        resumeRequiredSalary: json["resume_required_salary"],
        resumeLanguageAbility: json["resume_language_ability"],
        resumeComputerSkills: json["resume_computer_skills"],
        resumeHistoryWork: json["resume_history_work"],
        resumeTraining: json["resume_training"],
        resumeAwarded: json["resume_awarded"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_titlename": userTitlename,
        "user_name": userName,
        "user_lastname": userLastname,
        "user_class": userClass,
        "user_gender": userGender,
        "user_phone": userPhone,
        "user_email": userEmail,
        "profile_img": profileImg,
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
        "resume_graduation": resumeGraduation,
        "resume_educational_place": resumeEducationalPlace,
        "resume_job_type_interested": resumeJobTypeInterested,
        "resume_required_salary": resumeRequiredSalary,
        "resume_language_ability": resumeLanguageAbility,
        "resume_computer_skills": resumeComputerSkills,
        "resume_history_work": resumeHistoryWork,
        "resume_training": resumeTraining,
        "resume_awarded": resumeAwarded,
      };
}
