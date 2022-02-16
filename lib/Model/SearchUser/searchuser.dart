// To parse this JSON data, do
//
//     final searchuser = searchuserFromJson(jsonString);

import 'dart:convert';

Searchuser searchuserFromJson(String str) => Searchuser.fromJson(json.decode(str));

String searchuserToJson(Searchuser data) => json.encode(data.toJson());

class Searchuser {
    Searchuser({
        this.error,
        this.msg,
    });

    int? error;
    List<Msg>? msg;

    factory Searchuser.fromJson(Map<String, dynamic> json) => Searchuser(
        error: json["error"],
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "msg": List<dynamic>.from(msg!.map((x) => x.toJson())),
    };
}

class Msg {
    Msg({
        this.userId,
        this.fullName,
        this.companyName,
        this.phone,
        this.email,
        this.userName,
        this.password,
        this.typeReg,
        this.serviceArea,
        this.status,
        this.createdAt,
        this.pic,
        this.nidStatus,
        this.nidFront,
        this.nidBack,
        this.address,
        this.verifiedMember,
        this.profileTagline,
        this.nidName,
        this.favorite,
    });

    String? userId;
    String? fullName;
    String? companyName;
    String? phone;
    String? email;
    dynamic userName;
    String? password;
    String? typeReg;
    String? serviceArea;
    String? status;
    DateTime? createdAt;
    String? pic;
    String? nidStatus;
    String? nidFront;
    String? nidBack;
    dynamic address;
    String? verifiedMember;
    String? profileTagline;
    dynamic nidName;
    dynamic favorite;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        userId: json["user_id"],
        fullName: json["full_name"],
        companyName: json["company_name"],
        phone: json["phone"],
        email: json["email"],
        userName: json["user_name"],
        password: json["password"],
        typeReg: json["type_reg"],
        serviceArea: json["service_area"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        pic: json["pic"],
        nidStatus: json["nid_status"],
        nidFront: json["nid_front"],
        nidBack: json["nid_back"],
        address: json["address"],
        verifiedMember: json["verified_member"],
        profileTagline: json["profile_tagline"],
        nidName: json["nid_name"],
        favorite: json["favorite"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "company_name": companyName,
        "phone": phone,
        "email": email,
        "user_name": userName,
        "password": password,
        "type_reg": typeReg,
        "service_area": serviceArea,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "pic": pic,
        "nid_status": nidStatus,
        "nid_front": nidFront,
        "nid_back": nidBack,
        "address": address,
        "verified_member": verifiedMember,
        "profile_tagline": profileTagline,
        "nid_name": nidName,
        "favorite": favorite,
    };
}
