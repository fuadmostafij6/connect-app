import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Const_value/snakbar.dart';
import 'package:jobs_app/Model/ApplicationList/applicationlist.dart';

import '../../Const_value/apilink.dart';

class JobApplyprovider extends ChangeNotifier {
  Future jobapply(
      {String? jobid, userid, time, note, BuildContext? context}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$url/api/job/applicationcreate'));
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
      var json = jsonDecode(responsedata.body);
      if (json['error'] == 0) {
        Fluttertoast.showToast(
            msg: json['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: json['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      notifyListeners();
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }

  ApplicationList? applicationList;

  Future getapplicationlist() async {
    var box = Hive.box('login');
    print(box.get('userid'));
    var headers = {
      'Cookie': 'ci_session=649058618641fd56bc6a8e4fc9e7ff864d1b19c4'
    };
    var request = http.Request(
        'GET', Uri.parse('$url/api/user/userapply/${box.get('userid')}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      print(responsedata.body);
      applicationList = applicationListFromJson(responsedata.body);
      notifyListeners();
    } else {
      print(responsedata.body);
    }
  }
}
