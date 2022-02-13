// To parse this JSON data, do
//
//     final searchJob = searchJobFromJson(jsonString);

import 'dart:convert';

SearchJob searchJobFromJson(String str) => SearchJob.fromJson(json.decode(str));

String searchJobToJson(SearchJob data) => json.encode(data.toJson());

class SearchJob {
    SearchJob({
        this.error,
        this.type,
        this.msg,
    });

    int? error;
    String? type;
    List<Msg>? msg;

    factory SearchJob.fromJson(Map<String, dynamic> json) => SearchJob(
        error: json["error"],
        type: json["type"],
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "type": type,
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
    String? doc;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        jobId: json["job_id"],
        jobTitle: json["job_title"],
        description: json["description"],
        contactnumber: json["contactnumber"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        createdBy: json["created_by"],
        doc: json["doc"] == null ? null : json["doc"],
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
        "doc": doc == null ? null : doc,
    };
}
