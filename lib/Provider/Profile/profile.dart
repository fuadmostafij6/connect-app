import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
            'https://launch1.goshrt.com/api/user/profile/${box.get('userid')}'));

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
}
