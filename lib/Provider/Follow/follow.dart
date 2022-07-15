import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Const_value/apilink.dart';

import '../../Model/Follow/follow.dart';
import 'package:http/http.dart' as http;

class FollowProvider extends ChangeNotifier {
  Follow? follow;

  Future followlistin(String type) async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=8b60b892cb6cdac140e0edd7f17a76733b8087b3'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/api/follow/listing?user_id=${box.get('userid')}&limit=1000&offset=0&type=$type'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);
    print(responsedata.body);
    follow = followFromJson(responsedata.body);
    notifyListeners();
  }

  Future followacton({String? profileid, String? status}) async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=8b60b892cb6cdac140e0edd7f17a76733b8087b3'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/api/follow/action?action=$status&user_id=${box.get('userid')}&user_profile_id=$profileid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }
}
