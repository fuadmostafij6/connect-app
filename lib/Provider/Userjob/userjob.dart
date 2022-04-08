import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Const_value/apilink.dart';
import '../../Model/Userjob/userjob.dart';
import 'package:http/http.dart' as http;

class Userjobpage extends ChangeNotifier {
  Userjob? userjob;

  Future getuserjob({String? userid}) async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=f5d17f81d2aedb8b50e0a834752b1a4849af7a8a'
    };
    var request =
        http.Request('GET', Uri.parse('$url/api/user/usersjob/$userid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {
        userjob = Userjob.fromJson(jsonDecode(responsedata.body));
        notifyListeners();
      } else {
        print(responsedata.body);
      }
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }

  Future removejob({String? jobid}) async {
    var box = Hive.box('login');
    var request = http.Request('GET', Uri.parse('$url/api/job/delete/$jobid/${box.get('userid')}'));

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
}
