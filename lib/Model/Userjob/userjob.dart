// To parse this JSON data, do
//
//     final userjob = userjobFromJson(jsonString);

import 'dart:convert';

Userjob userjobFromJson(String str) => Userjob.fromJson(json.decode(str));

String userjobToJson(Userjob data) => json.encode(data.toJson());

class Userjob {
    Userjob({
        this.error,
        this.msg,
    });

    int? error;
    List<Msg>? msg;

    factory Userjob.fromJson(Map<String, dynamic> json) => Userjob(
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
        this.jobId,
        this.jobTitle,
        this.description,
        this.contactnumber,
        this.category,
        this.createdAt,
        this.status,
        this.createdBy,
        this.doc,
    });

    String? jobId;
    String? jobTitle;
    String? description;
    String? contactnumber;
    String? category;
    DateTime? createdAt;
    String? status;
    String? createdBy;
    dynamic doc;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        jobId: json["job_id"],
        jobTitle: json["job_title"],
        description: json["description"],
        contactnumber: json["contactnumber"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        createdBy: json["created_by"],
        doc: json["doc"],
    );

    Map<String, dynamic> toJson() => {
        "job_id": jobId,
        "job_title": jobTitle,
        "description": description,
        "contactnumber": contactnumber,
        "category": category,
        "created_at": createdAt!.toIso8601String(),
        "status": status,
        "created_by": createdBy,
        "doc": doc,
    };
}
