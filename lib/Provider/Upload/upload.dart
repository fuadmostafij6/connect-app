import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Const_value/apilink.dart';

class UploadProvider extends ChangeNotifier {
  bool loading = false;

  Future uploaddile(String path) async {
    var box = Hive.box('login');
    loading = true;
    var request = http.MultipartRequest(
        'POST', Uri.parse('$url/api/uploader/up/${box.get('userid')}'));
    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var json = jsonDecode(responsedata.body);
      if (json['error'] == 0) {
        Fluttertoast.showToast(
            msg: "Upload Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }else{
        print(json['msg'] + "msgggg");
        Fluttertoast.showToast(
            msg: json['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      loading = false;
      notifyListeners();
    } else {
      print(responsedata.body);
      notifyListeners();
    }
  }
}
