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
    List<Msgs>? msg;

    factory Userjob.fromJson(Map<String, dynamic> json) => Userjob(
        error: json["error"],
        msg: List<Msgs>.from(json["msg"].map((x) => Msgs.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "msg": List<dynamic>.from(msg!.map((x) => x.toJson())),
    };
}

class Msgs {
    Msgs({
        this.jobId,
        this.jobTitle,
        this.description,
        this.contactnumber,
        this.category,
        this.createdAt,
        this.status,
        this.createdBy,
        this.doc,
        this.createdByName,
    });

    String? jobId;
    String? jobTitle;
    String? description;
    String? contactnumber;
    String? category;
    DateTime? createdAt;
    String? status;
    String? createdBy;
    List<String>? doc;
    String? createdByName;

    factory Msgs.fromJson(Map<String, dynamic> json) => Msgs(
        jobId: json["job_id"],
        jobTitle: json["job_title"],
        description: json["description"],
        contactnumber: json["contactnumber"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        createdBy: json["created_by"],
        doc: json["doc"] == null ? null : List<String>.from(json["doc"].map((x) => x)),
        createdByName: json["created_by_name"],
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
         "doc": doc == null ? null : List<dynamic>.from(doc!.map((x) => x)),
        "created_by_name": createdByName,
    };
}
