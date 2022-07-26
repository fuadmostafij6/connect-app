
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../Model/UserProfileModel/UserProfileModel.dart';

class UserProfileProvider with ChangeNotifier{
  Map<String, dynamic> _map ={};
  UserProfileModel? userProfileModel;
  bool _error = true;
  String _errorMessage = "";
  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errrMessege => _errorMessage;

  Future  fetchData (String id) async{
    var headers = {
      'Cookie': 'ci_session=649058618641fd56bc6a8e4fc9e7ff864d1b19c4'
    };
    final res = await get(
      Uri.parse("https://new.goshrt.com/api/user/profile/$id"),


    );
    res.headers.addAll(headers);
    if (res.statusCode == 200){
      _map = jsonDecode(res.body);
      _error = false;
      notifyListeners();
      try{


        userProfileModel =  UserProfileModel.fromJson(_map);
        notifyListeners();

        _error = false;

      }
      catch(e){
        _error = true;
        _errorMessage = e.toString();
        notifyListeners();
      }



    }
    else{
      _error = true;
      _errorMessage = "no internet";
      _map ={};
      notifyListeners();


    }
    notifyListeners();
  }

  void initialValues(){
    _error = false;
    _errorMessage = "";
    _map ={};
    notifyListeners();
  }

}