import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Const_value/snakbar.dart';

import '../../Const_value/apilink.dart';

class JobApplyprovider extends ChangeNotifier {
  Future jobapply(
      {String? jobid, userid, time, note, BuildContext? context}) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('$url/api/job/applicationcreate'));
    request.fields.addAll({
      'job_id': jobid!,
      'user_id': userid,
      'time': time,
      'job_owner': '1',
      'note': note
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      print(responsedata.body);
      Message().scaffoldmessage(
          context!, jsonDecode(responsedata.body)['msg'].toString());
      notifyListeners();
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }
}
