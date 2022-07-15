// To parse this JSON data, do
//
//     final messageBoxlist = messageBoxlistFromJson(jsonString);

import 'dart:convert';

MessageBoxlist messageBoxlistFromJson(String str) => MessageBoxlist.fromJson(json.decode(str));

String messageBoxlistToJson(MessageBoxlist data) => json.encode(data.toJson());

class MessageBoxlist {
    MessageBoxlist({
        this.error,
        this.msg,
    });

    int? error;
    List<Msg>? msg;

    factory MessageBoxlist.fromJson(Map<String, dynamic> json) => MessageBoxlist(
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
        this.msgId,
        this.jobId,
        this.applyId,
        this.senderId,
        this.msg,
        this.doc,
        this.isReply,
        this.createdAt,
        this.name,
        this.photo,
    });

    String? msgId;
    String? jobId;
    String ?applyId;
    String? senderId;
    String? msg;
    dynamic doc;
    String? isReply;
    DateTime? createdAt;
    String? name;
    String? photo;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        msgId: json["msg_id"],
        jobId: json["job_id"],
        applyId: json["apply_id"],
        senderId: json["sender_id"],
        msg: json["msg"],
        doc: json["doc"],
        isReply: json["is_reply"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "msg_id": msgId,
        "job_id": jobId,
        "apply_id": applyId,
        "sender_id": senderId,
        "msg": msg,
        "doc": doc,
        "is_reply": isReply,
        "created_at": createdAt!.toIso8601String(),
        "name": name,
        "photo": photo,
    };
}
