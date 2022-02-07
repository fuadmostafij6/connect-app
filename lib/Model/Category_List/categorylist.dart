class Categorylist {
  int? error;
  List<Msg>? msg;

  Categorylist({this.error, this.msg});

  Categorylist.fromJson(Map<String, dynamic> json) {
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
  String? catId;
  String? catName;
  String? catNameUrl;
  String? image;
  String? status;
  String? createdAt;

  Msg(
      {this.catId,
      this.catName,
      this.catNameUrl,
      this.image,
      this.status,
      this.createdAt});

  Msg.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catNameUrl = json['cat_name_url'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_name_url'] = this.catNameUrl;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}