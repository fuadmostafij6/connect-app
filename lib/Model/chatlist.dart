import 'package:flutter/cupertino.dart';

class ChatListModel {
  String? name;
  AssetImage? image;
  String? date;
  String? lastmessage;
  int? seenstatus;
  int? audiostatus;
  ChatListModel(
      {this.audiostatus,
      this.date,
      this.image,
      this.lastmessage,
      this.name,
      this.seenstatus});
}

List<ChatListModel> chatlist = [
  ChatListModel(
      audiostatus: 0,
      date: "08/05/19",
      image: AssetImage('images/Chat_list/1.jpg'),
      lastmessage: "Yes, 2pm is awasoom",
      name: "রফিক হাসান",
      seenstatus: 1),
  ChatListModel(
      audiostatus: 0,
      date: "10/19/19",
      image: const AssetImage('images/Chat_list/1.jpg'),
      lastmessage: "What kind of stragtegy is better?",
      name: "সাইদুল ইসলাম",
      seenstatus: 1),
  ChatListModel(
      audiostatus: 1,
      date: "25/10/19",
      image: const AssetImage('images/Chat_list/1.jpg'),
      lastmessage: "Yes, 2pm is awasoom",
      name: "নাজমুল ইসলাম",
      seenstatus: 1),
  ChatListModel(
      audiostatus: 0,
      date: "29/04/19",
      image: const AssetImage('images/Chat_list/1.jpg'),
      lastmessage: "Yes, 2pm is awasoom",
      name: "সাকিব খান",
      seenstatus: 1),
  ChatListModel(
      audiostatus: 0,
      date: "17/06/19",
      image: AssetImage('images/Chat_list/1.jpg'),
      lastmessage: "Yes, 2pm is awasoom",
      name: "অঙ্কুর ইসলাম",
      seenstatus: 1),
  ChatListModel(
      audiostatus: 0,
      date: "19/01/19",
      image: AssetImage('images/Chat_list/1.jpg'),
      lastmessage: "Yes, 2pm is awasoom",
      name: "রাকিব খান",
      seenstatus: 0),
  ChatListModel(
      audiostatus: 0,
      date: "23/03/19",
      image: AssetImage('images/Chat_list/1.jpg'),
      lastmessage: "Yes, 2pm is awasoom",
      name: "তামিম হাসান",
      seenstatus: 1),
];
