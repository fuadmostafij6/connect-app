import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Const_value/apilink.dart';
import '../../Model/ApplicationList/AppliedList.dart';




class ApplicationListProvider with ChangeNotifier {
  BuildContext? context;

  Map<String, dynamic> _map = {};
  bool _error = false;

  String _errorMessage = "";
  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  // ApplicationListProvider() {
  //   fetchData("1");
  // }

  void setView(BuildContext context) => this.context = context;





  void initialValues() {
    _map = {};
    _errorMessage = "";
    _error = false;
    notifyListeners();
  }
}
