import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Const_value/snakbar.dart';
import 'package:jobs_app/Model/Search_Job/searchjob.dart';
import 'package:http/http.dart' as http;

class Searchprovider extends ChangeNotifier {
  SearchJob? searchJob;

  Future getsearchjob({String? keyword, BuildContext? context}) async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=e777c4fe949f8c89154635adb58040dd7f482097'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://launch1.goshrt.com/api/search/filter?key_word=$keyword&user_id=${box.get('userid')}&type=1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(responsedata.body);
      if (jsondata['error'] == 0) {
        searchJob = SearchJob.fromJson(jsonDecode(responsedata.body));
        notifyListeners();
      } else {
        print("sjkhdbcsjhd");
        Message().scaffoldmessage(context!, "Job Not Found");
      }
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }
}
