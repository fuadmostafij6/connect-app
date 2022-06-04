import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Const_value/apilink.dart';
import 'package:jobs_app/Model/Notification/notification.dart';

class NotificationProvider extends ChangeNotifier {
  Future<Notifications?> getnotification() async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=8cf21d0c568bfe0f911dbe90409694fc1a08f6b4'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/api/notification/read?receiver_id=${box.get('userid')}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return notificationFromJson(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
