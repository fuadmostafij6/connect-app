import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Model/Following/following.dart';
import 'package:jobs_app/Model/Postlinkuser/postlinkuser.dart';

import '../../Const_value/apilink.dart';
import '../../Model/Profile/profile.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  Profile? profile;

  Future getprofileinfo() async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=6462a9d3495609d2caf8d9a99a5fdb8325123111'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/api/user/profile/${box.get('userid')}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      profile = Profile.fromJson(jsonDecode(responsedata.body));
      notifyListeners();
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }

  Future followaction({String? action, userid, userprofileid}) async {
    var headers = {
      'Cookie': 'ci_session=9d28b8137e3efdce4d19a5c2d3140dcbd0d306c7'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://launch1.goshrt.com/api/follow/action?action=$action&user_id=$userid&user_profile_id=$userprofileid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      print(responsedata.body);
    } else {
      print(responsedata.body);
    }
  }

  Future followstatuscheck({String? userid, userprofileid}) async {
    var headers = {
      'Cookie': 'ci_session=9d28b8137e3efdce4d19a5c2d3140dcbd0d306c7'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://launch1.goshrt.com/api/follow/followstatus?user_id=2&user_profile_id=5'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsedata.body);
      notifyListeners();
      return data;
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }

  Postlinkuser? postlinkuser;

  Future getpostlinkuser({String? userid, String? mainuserid}) async {
    var headers = {
      'Cookie': 'ci_session=078502072d22dd8f57fd941184a9d4dffcc1898d'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://launch1.goshrt.com/api/user/profile/$userid/1/$mainuserid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      postlinkuser = postlinkuserFromJson(responsedata.body);
      notifyListeners();
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }

  Following? following;

  Future getfollowing({String? type}) async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=b9761a6ab237259e012629d2dc8c591188119af6'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://launch1.goshrt.com/api/follow/listing?user_id=${box.get('userid')}&limit=10&offset=0&type=$type'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {
        following = followingFromJson(responsedata.body);
        notifyListeners();
      } else {
        following = null;
        notifyListeners();
      }
    } else {
      print(responsedata.body);
    }
  }
}
