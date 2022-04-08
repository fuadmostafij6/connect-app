import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Const_value/apilink.dart';
import 'package:jobs_app/Model/Userprevilies/userprevilies.dart';

class UserPreviliesProvider extends ChangeNotifier {
  UserPrevilies? userPrevilies;

  Future getuserprevilies() async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=43a1f166f11bdb4d991f94da59b2b1d1bfc66888'
    };
    var request = http.Request(
        'GET', Uri.parse('$url/api/user/privilege/${box.get('userid')}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var json = jsonDecode(responsedata.body);
      if (json['error'] == 0) {
        userPrevilies = userPreviliesFromJson(responsedata.body);
      } else {
        print(responsedata.body);
      }

      notifyListeners();
    } else {
      print(responsedata.body);
    }
  }
}
