import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Const_value/snakbar.dart';
import 'package:jobs_app/Screen/home/homescrren.dart';

import '../../homepage.dart';

class Fromprovider extends ChangeNotifier {
  Future createuser(
      {String? name,
      email,
      company,
      phone,
      password,
      repassword,
      BuildContext? context}) async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=b67a5884fdd7066529f93d63c65aa183fc877b25'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://launch1.goshrt.com/api/user/register'));
    request.fields.addAll({
      'full_name': name!,
      'email': email,
      'profile_tagline': 'web development',
      'company_name': company,
      'phone': phone,
      'password': password,
      're_pass': repassword
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(responsedata.body);
      if (jsondata['error'] == 0) {
        Message().scaffoldmessage(context!,
            '${jsonDecode(responsedata.body)['msg'].toString()}. Login Now');

        notifyListeners();
      } else {
        Message().scaffoldmessage(
            context!, jsonDecode(responsedata.body)['msg'].toString());
        notifyListeners();
      }
    } else {
      print(responsedata.body);
    }
  }

  Future getlogin({String? email, password, BuildContext? context}) async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=7b8d5d53e011803fe34ede127514fe1dec213c21'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://launch1.goshrt.com/api/user/login'));
    request.fields.addAll({'email': email!, 'password': password});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(responsedata.body);
      if (jsondata['error'] == 0) {
        box.put('email', jsondata['msg']['UserEmail']);
        box.put('userid', jsondata['msg']['mainUserId']);
        Message().scaffoldmessage(context!, "Login Successfull");
        redirecthomepage(context, const Homepage());
        notifyListeners();
      } else {
        Message().scaffoldmessage(
            context!, jsonDecode(responsedata.body)['msg'].toString());
        notifyListeners();
      }
    } else {
      print(responsedata.body);
    }
  }

  void redirecthomepage(BuildContext context, Widget pagename) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => pagename,
        ),
        (route) => false);
  }
}
