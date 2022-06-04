// To parse this JSON data, do
//
//     final memebrpackagelist = memebrpackagelistFromJson(jsonString);

import 'dart:convert';

Memebrpackagelist memebrpackagelistFromJson(String str) => Memebrpackagelist.fromJson(json.decode(str));

String memebrpackagelistToJson(Memebrpackagelist data) => json.encode(data.toJson());

class Memebrpackagelist {
    Memebrpackagelist({
        this.error,
        this.msg,
    });

    int? error;
    List<Package>? msg;

    factory Memebrpackagelist.fromJson(Map<String, dynamic> json) => Memebrpackagelist(
        error: json["error"],
        msg: List<Package>.from(json["msg"].map((x) => Package.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "msg": List<dynamic>.from(msg!.map((x) => x.toJson())),
    };
}

class Package {
    Package({
        this.packageId,
        this.title,
        this.price,
        this.details,
        this.privilege,
        this.status,
    });

    String? packageId;
    String? title;
    String? price;
    String? details;
    Privilege? privilege;
    String? status;

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageId: json["package_id"],
        title: json["title"],
        price: json["price"],
        details: json["details"],
        privilege: Privilege.fromJson(json["privilege"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "title": title,
        "price": price,
        "details": details,
        "privilege": privilege!.toJson(),
        "status": status,
    };
}

class Privilege {
    Privilege({
        this.postLimit,
        this.applyLimit,
        this.phone,
        this.category,
    });

    int? postLimit;
    int? applyLimit;
    int? phone;
    int? category;

    factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
        postLimit: json["post_limit"],
        applyLimit: json["apply_limit"],
        phone: json["phone"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "post_limit": postLimit,
        "apply_limit": applyLimit,
        "phone": phone,
        "category": category,
    };
}
