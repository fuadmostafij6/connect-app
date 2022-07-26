import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jobs_app/Const_value/snakbar.dart';

import '../../Const_value/apilink.dart';
import '../../Model/ApplicationList/AppliedList.dart';

class JobApplyprovider extends ChangeNotifier {
  Map<String, dynamic> _map ={};
  bool _error = true;
  String _errorMessage = "";
  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errrMessege => _errorMessage;
  Future jobapply(
      {String? jobid, userid, time,ownerId, note, BuildContext? context}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$url/api/job/applicationcreate'));
    request.fields.addAll({
      'job_id': jobid!,
      'user_id': userid,
      'time': time,
      'job_owner': '1',
      'note': note,
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

  Future getapplicationlist(String id) async {
    var box = Hive.box('login');
    print(box.get('userid'));
    var headers = {
      'Cookie': 'ci_session=649058618641fd56bc6a8e4fc9e7ff864d1b19c4'
    };
    var request = http.Request(
        'GET', Uri.parse('https://new.goshrt.com/api/job/jobapplylisting/$id}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);
    print(response.statusCode);
    print("response.statusCode");

    if (response.statusCode == 200) {
      _map = jsonDecode(responsedata.body);
     print(_map.toString()+"msggg");
     try{
       applicationList = applicationListFromJson(responsedata.body);
       print(applicationList?.msg);
       _error = false;
       notifyListeners();
       print("list1");
     }

     catch(e){
       _error = false;
       notifyListeners();
     }


      notifyListeners();
    } else {

      _errorMessage = "May Be Internet Issue";
      _map = {};
      _error = true;
      notifyListeners();
      print(responsedata.body + "qeqrq");
    }
  }


  // ApplicationListModel? applicationList;

  // Future getapplicationlist(String id) async {
  //   var box = Hive.box('login');
  //   print(box.get('userid'));
  //   var headers = {
  //     'Cookie': 'ci_session=649058618641fd56bc6a8e4fc9e7ff864d1b19c4'
  //   };
  //   var request = http.Request(
  //       'GET', Uri.parse('https://new.goshrt.com/api/job/jobapplicationdetails/$id'));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   var responsedata = await http.Response.fromStream(response);
  //
  //   if (response.statusCode == 200) {
  //     print(responsedata.body +"apply");
  //     applicationList = applicationListFromJson(responsedata.body);
  //     notifyListeners();
  //   } else {
  //     print(responsedata.body+"apply");
  //   }
  //   notifyListeners();
  // }


}
