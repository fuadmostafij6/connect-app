// To parse this JSON data, do
//
//     final messagelist = messagelistFromJson(jsonString);

import 'dart:convert';

Messagelist messagelistFromJson(String str) => Messagelist.fromJson(json.decode(str));

String messagelistToJson(Messagelist data) => json.encode(data.toJson());

class Messagelist {
    Messagelist({
        this.error,
        this.profile,
        this.msg,
    });

    int? error;
    Profile? profile;
    List<Msg>? msg;

    factory Messagelist.fromJson(Map<String, dynamic> json) => Messagelist(
        error: json["error"],
        profile: Profile.fromJson(json["profile"]),
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "profile": profile!.toJson(),
        "msg": List<dynamic>.from(msg!.map((x) => x.toJson())),
    };
}

class Msg {
    Msg({
        this.messageId,
        this.msg,
        this.doc,
        this.isReply,
        this.createdAt,
        this.fullName,
        this.profileTagline,
        this.pic,
        this.receiverUserId,
        this.senderUserId,
    });

    String? messageId;
    String? msg;
    dynamic doc;
    String? isReply;
    DateTime? createdAt;
    String? fullName;
    String? profileTagline;
    String? pic;
    String? receiverUserId;
    String? senderUserId;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        messageId: json["message_id"],
        msg: json["msg"],
        doc: json["doc"],
        isReply: json["is_reply"],
        createdAt: DateTime.parse(json["created_at"]),
        fullName: json["full_name"],
        profileTagline: json["profile_tagline"],
        pic: json["pic"],
        receiverUserId: json["receiver_user_id"],
        senderUserId: json["sender_user_id"],
    );

    Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "msg": msg,
        "doc": doc,
        "is_reply": isReply,
        "created_at": createdAt!.toIso8601String(),
        "full_name": fullName,
        "profile_tagline": profileTagline,
        "pic": pic,
        "receiver_user_id": receiverUserId,
        "sender_user_id": senderUserId,
    };
}

class Profile {
    Profile({
        this.userId,
        this.name,
        this.taglne,
        this.profilepic,
    });

    String? userId;
    String? name;
    String? taglne;
    String? profilepic;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        userId: json["user_id"],
        name: json["name"],
        taglne: json["taglne"],
        profilepic: json["profilepic"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "taglne": taglne,
        "profilepic": profilepic,
    };
}
