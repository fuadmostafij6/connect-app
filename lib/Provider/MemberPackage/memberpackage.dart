import 'package:flutter/material.dart';
import 'package:jobs_app/Const_value/apilink.dart';

import '../../Model/PackageList/packagelist.dart';
import 'package:http/http.dart' as http;

class PackageProvider extends ChangeNotifier {
  Memebrpackagelist? memebrpackagelist;

  Future getpackagelist() async {
    var headers = {
      'Cookie': 'ci_session=dc6a0b4d98cbf0e80f63a831b2653b844260686a'
    };
    var request =
        http.Request('GET', Uri.parse('$url/api/membership/packages'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      memebrpackagelist =
          memebrpackagelistFromJson(await response.stream.bytesToString());
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }
}
