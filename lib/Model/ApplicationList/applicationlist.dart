// To parse this JSON data, do
//
//     final applicationList = applicationListFromJson(jsonString);

import 'dart:convert';

ApplicationList applicationListFromJson(String str) => ApplicationList.fromJson(json.decode(str));

String applicationListToJson(ApplicationList data) => json.encode(data.toJson());

class ApplicationList {
    ApplicationList({
        this.error,
        this.msg,
    });

    int? error;
    List<Msg>?msg;

    factory ApplicationList.fromJson(Map<String, dynamic> json) => ApplicationList(
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
        this.applyId,
        this.jobId,
        this.ownerId,
        this.userId,
        this.time,
        this.price,
        this.doc,
        this.note,
        this.status,
        this.isChecked,
        this.createdAt,
    });

    String? applyId;
    String? jobId;
    String? ownerId;
    String ?userId;
    String? time;
    String? price;
    String?doc;
    String? note;
    String? status;
    String? isChecked;
    DateTime? createdAt;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        applyId: json["apply_id"],
        jobId: json["job_id"],
        ownerId: json["owner_id"],
        userId: json["user_id"],
        time: json["time"],
        price: json["price"],
        doc: json["doc"],
        note: json["note"],
        status: json["status"],
        isChecked: json["is_checked"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "apply_id": applyId,
        "job_id": jobId,
        "owner_id": ownerId,
        "user_id": userId,
        "time": time,
        "price": price,
        "doc": doc,
        "note": note,
        "status": status,
        "is_checked": isChecked,
        "created_at": createdAt!.toIso8601String(),
    };
}
