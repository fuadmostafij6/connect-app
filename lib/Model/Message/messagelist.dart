class MessageModel {
  String? message;
  String? time;
  int? seen;
  int? sendme;
  int? filetype;

  MessageModel(
      {this.message, this.filetype, this.seen, this.sendme, this.time});
}

List<MessageModel> messagelist = [
  MessageModel(
      filetype: 0, message: "Good Bye", seen: 1, sendme: 0, time: "17:47"),
  MessageModel(
      filetype: 0,
      message:
          "Good Byehjfdbvskdbvsdbvsjdhbvsjdhvsjhcvsjdhvcsjdhbcvjsdhbvjshvbsdcdfdfbfbdfbdfbdfbdfbdfbdfbdfbfbdnfgmhmjhjgthyjnj",
      seen: 1,
      sendme: 1,
      time: "17:47"),
  MessageModel(
      filetype: 0,
      message: "Good Byehjfdbvskdbvsdbvsjdhbvsjdhvs",
      seen: 1,
      sendme: 1,
      time: "17:47"),
  MessageModel(
      filetype: 0, message: "Good Bye", seen: 1, sendme: 1, time: "17:47"),
  MessageModel(
      filetype: 0, message: "Good Bye", seen: 1, sendme: 1, time: "17:47"),
  MessageModel(
      filetype: 0, message: "Good Bye", seen: 1, sendme: 1, time: "17:47"),
  MessageModel(
      filetype: 1, message: "Good Bye", seen: 1, sendme: 1, time: "17:47"),
];
