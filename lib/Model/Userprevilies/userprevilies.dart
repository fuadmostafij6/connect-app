// To parse this JSON data, do
//
//     final userPrevilies = userPreviliesFromJson(jsonString);

import 'dart:convert';

UserPrevilies userPreviliesFromJson(String str) => UserPrevilies.fromJson(json.decode(str));

String userPreviliesToJson(UserPrevilies data) => json.encode(data.toJson());

class UserPrevilies {
    UserPrevilies({
        this.error,
        this.msg,
    });

    int? error;
    Msg? msg;

    factory UserPrevilies.fromJson(Map<String, dynamic> json) => UserPrevilies(
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
        this.postLimit,
        this.applyLimit,
        this.phone,
        this.category,
    });

    int? postLimit;
    int? applyLimit;
    int? phone;
    int? category;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        postLimit: json["post_limit"],
        applyLimit: json["apply_limit"],
        phone: json["phone"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "post_limit": postLimit,
        "apply_limit": applyLimit,
        "phone": phone,
        "category": category,
    };
}
