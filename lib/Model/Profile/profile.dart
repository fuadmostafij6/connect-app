class Profile {
  int? error;
  Msg? msg;

  Profile({this.error, this.msg});

  Profile.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'] != null ? new Msg.fromJson(json['msg']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.msg != null) {
      data['msg'] = this.msg!.toJson();
    }
    return data;
  }
}

class Msg {
  UserData? userData;
  Null? membership;

  Msg({this.userData, this.membership});

  Msg.fromJson(Map<String, dynamic> json) {
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    membership = json['membership'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    data['membership'] = this.membership;
    return data;
  }
}

class UserData {
  String? userId;
  String? fullName;
  String? companyName;
  String? phone;
  String? email;
  Null? userName;
  String? password;
  Null? typeReg;
  String? serviceArea;
  String? status;
  String? createdAt;
  Null? pic;
  String? nidStatus;
  String? nidFront;
  String? nidBack;
  Null? address;
  String? verifiedMember;
  String? profileTagline;
  Null? nidName;
  Null? favorite;

  UserData(
      {this.userId,
      this.fullName,
      this.companyName,
      this.phone,
      this.email,
      this.userName,
      this.password,
      this.typeReg,
      this.serviceArea,
      this.status,
      this.createdAt,
      this.pic,
      this.nidStatus,
      this.nidFront,
      this.nidBack,
      this.address,
      this.verifiedMember,
      this.profileTagline,
      this.nidName,
      this.favorite});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    companyName = json['company_name'];
    phone = json['phone'];
    email = json['email'];
    userName = json['user_name'];
    password = json['password'];
    typeReg = json['type_reg'];
    serviceArea = json['service_area'];
    status = json['status'];
    createdAt = json['created_at'];
    pic = json['pic'];
    nidStatus = json['nid_status'];
    nidFront = json['nid_front'];
    nidBack = json['nid_back'];
    address = json['address'];
    verifiedMember = json['verified_member'];
    profileTagline = json['profile_tagline'];
    nidName = json['nid_name'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['company_name'] = this.companyName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['type_reg'] = this.typeReg;
    data['service_area'] = this.serviceArea;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['pic'] = this.pic;
    data['nid_status'] = this.nidStatus;
    data['nid_front'] = this.nidFront;
    data['nid_back'] = this.nidBack;
    data['address'] = this.address;
    data['verified_member'] = this.verifiedMember;
    data['profile_tagline'] = this.profileTagline;
    data['nid_name'] = this.nidName;
    data['favorite'] = this.favorite;
    return data;
  }
}