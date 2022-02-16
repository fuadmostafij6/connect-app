import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Const_value/snakbar.dart';
import 'package:jobs_app/Model/SearchUser/searchuser.dart';
import 'package:jobs_app/Model/Search_Job/searchjob.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Model/Searchcategory/searchcategory.dart';

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

  Searchuser? searchuser;

  Future getsearchuser(
      {String? keyword, BuildContext? context, int? type}) async {
    print(keyword);
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=48992169d438e8d18248cc6d509f325251184d7e'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://launch1.goshrt.com/api/search/filter?key_word=$keyword&user_id=${box.get('userid')}&type=$type'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {
        searchuser = searchuserFromJson(responsedata.body);
        notifyListeners();
      } else {
        print(responsedata.body);
        searchuser!.msg!.clear();
      }
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }

  Searchcategory? searchcategory;

  Future getsearchcategory(
      {String? keyword, BuildContext? context, int? type}) async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=3ad783be893559d8b25178b3aee7b1c28d5084cb'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://launch1.goshrt.com/api/search/filter?key_word=$keyword&user_id=${box.get('userid')}&type=$type'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error'] == 0) {
        searchcategory = Searchcategory.fromJson(jsonDecode(responsedata.body));
        notifyListeners();
      } else {
        print(responsedata.body);
      }
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }
}
