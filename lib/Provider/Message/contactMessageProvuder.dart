import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../../Model/Messagelist/contactMessageList.dart';

class ContactMessageProvider with ChangeNotifier{
  Map<String, dynamic> _map ={};
  ContactMessageList? contactMessageList;
  bool _error = false;
  String _errorMessage = "";
  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errrMessege => _errorMessage;

  Future<ContactMessageList?> getContactMessageList() async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=e401ba950f654b18428d6acc69cae96ad369ab43'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse("https://new.goshrt.com/api/message/all?user_id=${box.get('userid')}"),);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      return contactMessageListFromJson(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
  // Future  fetchData () async{
  //   var box = Hive.box('login');
  //   var headers = {
  //     'Cookie': 'ci_session=649058618641fd56bc6a8e4fc9e7ff864d1b19c4'
  //   };
  //   final res = await get(
  //     Uri.parse("https://new.goshrt.com/api/message/all?user_id=${box.get('userid')}"),
  //
  //
  //   );
  //   res.headers.addAll(headers);
  //   if (res.statusCode == 200){
  //     try{
  //       _map = jsonDecode(res.body);
  //       contactMessageList =  ContactMessageList.fromJson(_map);
  //
  //       _error = false;
  //
  //     }
  //     catch(e){
  //       _error = true;
  //       _errorMessage = e.toString();
  //       _map ={};
  //     }
  //
  //
  //
  //   }
  //   else{
  //     _error = true;
  //     _errorMessage = "no internet";
  //     _map ={};
  //
  //
  //   }
  //   notifyListeners();
  // }

  Stream<ContactMessageList?> streammessage(
      Duration? refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime!);
      yield await getContactMessageList();
    }
  }

  void initialValues(){
    _error = false;
    _errorMessage = "";
    _map ={};
    notifyListeners();
  }

}