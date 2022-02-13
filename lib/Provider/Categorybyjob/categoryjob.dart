import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Model/job_List/joblist.dart';

class CategoryJobprovider extends ChangeNotifier {
  Joblist? joblist;
  Future getcategoryjob(String categoryid) async {
    var request = http.Request('GET',
        Uri.parse('https://launch1.goshrt.com/api/job/catjob/$categoryid'));

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
