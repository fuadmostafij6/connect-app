import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_app/Const_value/apilink.dart';
import 'package:jobs_app/Model/Messagelist/messagelist.dart';

import '../../Model/MessageBox/messageboxlist.dart';

class MessageProvider extends ChangeNotifier {
  Future messagesend(
      {String? recvid, senderid, applyid, jobid, message, photo}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$url/api/message/sendmsg'));
    request.fields.addAll({
      'recv_id': recvid!,
      'sender_id': senderid,
      'apply_id': applyid,
      'job_id': jobid,
      'message': message
    });
    if (photo != "") {
      request.files.add(await http.MultipartFile.fromPath('file', photo));
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
  Messagelist ? messagelist;
  Stream<Messagelist?> streammessage(
      {Duration? refreshTime,
      String? recvid,
      senderid,
      applyid,
      jobid}) async* {
    while (true) {
      await Future.delayed(refreshTime!);
      yield await getmessagelist(applyid, jobid);
    }
  }

  Future<Messagelist?> getmessagelist(String? applyid, jobid) async {
    var headers = {
      'Cookie': 'ci_session=e401ba950f654b18428d6acc69cae96ad369ab43'
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '$url/api/message/conversation?apply_id=$applyid&job_id=$jobid'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      return messagelistFromJson(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<MessageBoxlist?> messageboxlist() async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=290806897eaac0b2c7f11c12a8ff56873fda1d72'
    };
    var request = http.Request(
        'GET', Uri.parse('$url/api/message/all?user_id=${box.get('userid')}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      if (json['error'] == 1) {
        return null;
      } else {
        return messageBoxlistFromJson(await response.stream.bytesToString());
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
