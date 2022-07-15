// To parse this JSON data, do
//
//     final follow = followFromJson(jsonString);

import 'dart:convert';

Follow followFromJson(String str) => Follow.fromJson(json.decode(str));

String followToJson(Follow data) => json.encode(data.toJson());

class Follow {
  Follow({
    this.error,
    this.msg,
  });

  int? error;
  Msg? msg;

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
        error: json["error"],
        msg: Msg.fromJson(json["msg"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "msg": msg!.toJson(),
      };
}

class Msg {
  Msg({
    this.limit,
    this.offset,
    this.type,
    this.result,
  });

  String? limit;
  int? offset;
  String? type;
  List<Result>? result;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        limit: json["limit"],
        offset: json["offset"],
        type: json["type"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "type": type,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.followId,
    this.followingId,
    this.followerId,
    this.status,
    this.userId,
    this.fullName,
    this.companyName,
    this.phone,
    this.email,
    this.userName,
    this.password,
    this.typeReg,
    this.serviceArea,
    this.pic,
    this.nidStatus,
    this.nidFront,
    this.nidBack,
    this.address,
    this.verifiedMember,
    this.profileTagline,
    this.nidName,
    this.favorite,
    this.followStatus,
  });

  String? followId;
  String? followingId;
  String? followerId;
  String? status;

  String? userId;
  String? fullName;
  String? companyName;
  String? phone;
  String? email;
  String? userName;
  String? password;
  String? typeReg;
  String? serviceArea;
  String? pic;
  String? nidStatus;
  String? nidFront;
  String? nidBack;
  String? address;
  String? verifiedMember;
  String? profileTagline;
  String? nidName;
  dynamic favorite;
  String? followStatus;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        followId: json["follow_id"],
        followingId: json["following_id"],
        followerId: json["follower_id"],
        status: json["status"],
        userId: json["user_id"],
        fullName: json["full_name"],
        companyName: json["company_name"],
        phone: json["phone"],
        email: json["email"],
        userName: json["user_name"],
        password: json["password"],
        typeReg: json["type_reg"],
        serviceArea: json["service_area"],
        pic: json["pic"],
        nidStatus: json["nid_status"],
        nidFront: json["nid_front"],
        nidBack: json["nid_back"],
        address: json["address"],
        verifiedMember: json["verified_member"],
        profileTagline: json["profile_tagline"],
        nidName: json["nid_name"],
        favorite: json["favorite"],
        followStatus: json["follow_status"],
      );

  Map<String, dynamic> toJson() => {
        "follow_id": followId,
        "following_id": followingId,
        "follower_id": followerId,
        "status": status,
        "user_id": userId,
        "full_name": fullName,
        "company_name": companyName,
        "phone": phone,
        "email": email,
        "user_name": userName,
        "password": password,
        "type_reg": typeReg,
        "service_area": serviceArea,
        "pic": pic,
        "nid_status": nidStatus,
        "nid_front": nidFront,
        "nid_back": nidBack,
        "address": address,
        "verified_member": verifiedMember,
        "profile_tagline": profileTagline,
        "nid_name": nidName,
        "favorite": favorite,
        "follow_status": followStatus,
      };
}
