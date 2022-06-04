import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Const_value/apilink.dart';
import 'package:jobs_app/Model/job_List/joblist.dart';

class CategoryJobprovider extends ChangeNotifier {
  Future getallcategory() async {
    var headers = {
      'Cookie': 'ci_session=8f6cb1866d4c0d0b1d3415e70baf177776ca6c13'
    };
    var request = http.Request(
        'GET', Uri.parse('https://new.goshrt.com/api/job/catlisting'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Joblist? joblist;
  Future getcategoryjob(String categoryid) async {
    var request =
        http.Request('GET', Uri.parse('$url/api/job/catjob/$categoryid'));

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {
        joblist = joblistFromJson(responsedata.body);
        notifyListeners();
      } else {
        joblist!.msg!.clear();
        notifyListeners();
      }
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }
}
