import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/Const_value/snakbar.dart';

import '../../Const_value/apilink.dart';
import '../../Model/Job_Details/jobdetails.dart';
import 'package:http/http.dart' as http;

class JobDetailsProvider extends ChangeNotifier {
  JobDetails? jobDetails;

  Future getjobdetails(String jobid) async {
    var headers = {
      'Cookie': 'ci_session=f5d17f81d2aedb8b50e0a834752b1a4849af7a8a'
    };
    var request = http.Request(
        'GET', Uri.parse('$url/api/job/single/$jobid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {
        jobDetails = JobDetails.fromJson(jsonDecode(responsedata.body));
        notifyListeners();
      } else {
        print(responsedata.body);
      }
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }

  Future newjobcreate(
      {String? jobtite,
      description,
      category,
      userid,
      contactnumber,
      BuildContext? context}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://launch1.goshrt.com/api/job/jobcreate'));
    request.fields.addAll({
      'job_title': jobtite!,
      'description': description,
      'category': category,
      'user_id': userid,
      'contactnumber': contactnumber,
      'doc': ''
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {
        Message().scaffoldmessage(
            context!, jsonDecode(responsedata.body)['msg'].toString());
        notifyListeners();
      } else {
        print(responsedata.body);
        Message().scaffoldmessage(
            context!, jsonDecode(responsedata.body)['msg'].toString());
        notifyListeners();
      }
    } else {
      print(responsedata.body);
    }
  }

  //video record

  String path = "";

  void getpath(String _path) {
    path = _path;
    notifyListeners();
  }
}
