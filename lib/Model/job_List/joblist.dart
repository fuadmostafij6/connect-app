class Joblist {
  int? error;
  List<Msg>? msg;

  Joblist({this.error, this.msg});

  Joblist.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['msg'] != null) {
      msg = <Msg>[];
      json['msg'].forEach((v) {
        msg!.add(new Msg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.msg != null) {
      data['msg'] = this.msg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Msg {
  String? jobId;
  String? jobTitle;
  String? description;
  String? contactnumber;
  String? category;
  String? createdAt;
  String? status;
  String? createdBy;
  String? doc;

  Msg(
      {this.jobId,
      this.jobTitle,
      this.description,
      this.contactnumber,
      this.category,
      this.createdAt,
      this.status,
      this.createdBy,
      this.doc});

  Msg.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    description = json['description'];
    contactnumber = json['contactnumber'];
    category = json['category'];
    createdAt = json['created_at'];
    status = json['status'];
    createdBy = json['created_by'];
    doc = json['doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['description'] = this.description;
    data['contactnumber'] = this.contactnumber;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['doc'] = this.doc;
    return data;
  }
}