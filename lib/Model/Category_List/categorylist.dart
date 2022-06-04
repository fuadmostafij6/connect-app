// To parse this JSON data, do
//
//     final allcategory = allcategoryFromJson(jsonString);

import 'dart:convert';

Allcategory allcategoryFromJson(String str) => Allcategory.fromJson(json.decode(str));

String allcategoryToJson(Allcategory data) => json.encode(data.toJson());

class Allcategory {
    Allcategory({
        this.error,
        this.msg,
    });

    int? error;
    List<Msg>? msg;

    factory Allcategory.fromJson(Map<String, dynamic> json) => Allcategory(
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
        this.catId,
        this.catName,
        this.catNameUrl,
        this.image,
        this.status,
        this.createdAt,
    });

    String? catId;
    String? catName;
    String? catNameUrl;
    String? image;
    String? status;
    String? createdAt;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        catId: json["cat_id"],
        catName: json["cat_name"],
        catNameUrl: json["cat_name_url"] == null ? null : json["cat_name_url"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "cat_name": catName,
        "cat_name_url": catNameUrl == null ? null : catNameUrl,
        "image": image,
        "status": status,
        "created_at": createdAt == null ? null : createdAt,
    };
}
