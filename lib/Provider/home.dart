import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Model/Category_List/categorylist.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Model/job_List/joblist.dart';

import '../Const_value/apilink.dart';

class HomeProvider extends ChangeNotifier {
  Allcategory? allcategory;

  Future getcategorylist() async {
    var headers = {
      'Cookie': 'ci_session=a9b0e8c8aefadafed1587e7f256e8e4f719f3809'
    };
    var request = http.Request('GET', Uri.parse('$url/api/job/catlisting'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      allcategory = allcategoryFromJson(responsedata.body);
      print(responsedata.body);
      notifyListeners();
    } else {
      print(responsedata.body);
    }
  }

  Joblist? joblist;

  Future getjoblist() async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=a9b0e8c8aefadafed1587e7f256e8e4f719f3809'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/api/job/listing?user_id=${box.get('userid')}&limit=20000&offset=0'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      joblist = Joblist.fromJson(jsonDecode(responsedata.body));
    } else {
      print(responsedata.body);
    }
  }
}
