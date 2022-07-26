// To parse this JSON data, do
//
//     final searchJob = searchJobFromJson(jsonString);

import 'dart:convert';

SearchJob searchJobFromJson(String str) => SearchJob.fromJson(json.decode(str));

String searchJobToJson(SearchJob data) => json.encode(data.toJson());

class SearchJob {
    SearchJob({
        this.error,
        this.msg,
    });

    int? error;
    List<Msg>? msg;

    factory SearchJob.fromJson(Map<String, dynamic> json) => SearchJob(
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
        this.canapply,
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
    int? canapply;
    String? createdByName;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        jobId: json["job_id"],
        jobTitle: json["job_title"],
        description: json["description"],
        contactnumber: json["contactnumber"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        createdBy: json["created_by"],
        doc: json["doc"] == null ? null : List<String>.from(json["doc"].map((x) => x)),
        canapply: json["canapply"],
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
        "canapply": canapply,
        "created_by_name": createdByName,
    };
}
