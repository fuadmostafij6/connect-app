import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    var request = http.Request('GET', Uri.parse('$url/api/job/single/$jobid/1'));

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

  Future newjobcreate({
    String? jobtite,
    description,
    category,
    userid,
    image,
    audio,
    video,
    contactnumber,
    BuildContext? context,
  }) async {
    print(image);
    print(audio);
    print(video);
    var request =
        http.MultipartRequest('POST', Uri.parse('$url/api/job/jobcreate'));

    request.fields.addAll({
      'job_title': jobtite!,
      'description': description,
      'category': category,
      'user_id': userid,
      'contactnumber': contactnumber,
      'image': image,
      'audio': audio,
      'video': video
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {
        Message().scaffoldmessage(
            context!, jsonDecode(responsedata.body)['msg'].toString());
        print(responsedata.body);
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

  Future jobupdate(
      {String? jobtite,
      jobid,
      description,
      category,
      userid,
      image,
    audio,
    video,
      contactnumber,
      BuildContext? context}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$url/api/job/updatepost/'));
    request.fields.addAll({
      'job_id': jobid,
      'job_title': jobtite!,
      'description': description,
      'category': category,
      'contactnumber': contactnumber,
      'image': image,
      'audio': audio,
      'video': video
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

  //video record

  String path = "";

  void getpath(String _path) {
    path = _path;
    notifyListeners();
  }
}
