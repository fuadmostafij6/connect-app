import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Model/Message/messagelist.dart';
import 'package:jobs_app/Model/Messagelist/messagelist.dart';
import 'package:jobs_app/Provider/Message/message.dart';
import 'package:provider/provider.dart';

import 'Custom_paint/custompaint.dart';

class ChatdetailsPage extends StatefulWidget {
  final String recvid, senderid, applyid, jobid;
  const ChatdetailsPage(
      {Key? key,
      required this.recvid,
      required this.senderid,
      required this.applyid,
      required this.jobid})
      : super(key: key);

  @override
  _ChatdetailsPageState createState() => _ChatdetailsPageState();
}

class _ChatdetailsPageState extends State<ChatdetailsPage> {
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mess = Provider.of<MessageProvider>(context);
    var box = Hive.box('login');
    return StreamBuilder<Messagelist?>(
        stream: mess.streammessage(
            applyid: widget.applyid,
            jobid: widget.jobid,
            recvid: widget.recvid,
            senderid: widget.senderid,
            refreshTime: Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Scaffold(
              backgroundColor: Color(0xFFFFFFFF),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: const Color(0xFFE51D20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                flexibleSpace: const Image(
                  image: AssetImage(
                    'images/Top Bar illustration Solid.png',
                  ),
                  fit: BoxFit.cover,
                ),
                title: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('images/Chat_list/1.jpg'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data!.profile!.name!,
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'Kalpurush'),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "tab here for contatc info",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFFEBEBEB)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      child: listmessage2(data),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 1)
                        ]),
                    child: Row(
                      children: [
                        Flexible(
                            child: TextFormField(
                          controller: message,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFCFCFD0)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFCFCFD0)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFCFCFD0)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFAFAFA)),
                        )),
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: Image.asset(
                        //       'images/message_icon/camera.png',
                        //       height: 27,
                        //     )),
                        IconButton(
                            onPressed: () {
                              mess
                                  .messagesend(
                                      applyid: widget.applyid,
                                      jobid: widget.jobid,
                                      recvid: widget.recvid,
                                      senderid: widget.senderid,
                                      message: message.text,
                                      photo: "")
                                  .then((value) => message.clear());
                            },
                            icon: Image.asset(
                              'images/send.png',
                              color: Colors.black,
                              height: 27,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0xFFE51D20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              flexibleSpace: const Image(
                image: AssetImage(
                  'images/Top Bar illustration Solid.png',
                ),
                fit: BoxFit.cover,
              ),
              title: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/Chat_list/1.jpg'),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "",
                          style:
                              TextStyle(fontSize: 17, fontFamily: 'Kalpurush'),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "tab here for contatc info",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFFEBEBEB)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ));
          }
        });
  }

  Widget listmessage2(Messagelist? data) {
    var box = Hive.box('login');
    final mess = Provider.of<MessageProvider>(context);
    data!.msg!.sort((a, b) => b.messageId!.compareTo(a.messageId!));
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 10),
        reverse: true,
        itemCount: data.msg!.length,
        itemBuilder: ((context, index) {
          var m = data.msg![index];
          return m.receiverUserId == widget.recvid ? rigthside(m) : leftside(m);
        }));
  }

  // Widget listmessage() {
  //   return ListView.builder(
  //     reverse: true,
  //     padding: EdgeInsets.only(bottom: 10),
  //     itemCount: messagelist.length,
  //     itemBuilder: (context, index) {
  //       var data = messagelist[index];
  //       // return Container(
  //       //   alignment:
  //       //       data.sendme == 1 ? Alignment.centerRight : Alignment.centerRight,
  //       //   child: Container(
  //       //     padding: EdgeInsets.all(10),
  //       //     margin: EdgeInsets.only(bottom: 5),
  //       //     constraints: BoxConstraints(maxWidth: 250),
  //       //     decoration: BoxDecoration(
  //       //         color: Color(0xFFFCE7E7),
  //       //         borderRadius: BorderRadius.circular(10)),
  //       //     child: Row(
  //       //       mainAxisSize: MainAxisSize.min,
  //       //       children: [
  //       //         Flexible(
  //       //           child: Column(
  //       //             mainAxisSize: MainAxisSize.max,
  //       //             children: [Text(data.message!)],
  //       //           ),
  //       //         ),
  //       //         Container(
  //       //           constraints: BoxConstraints(
  //       //             maxHeight: double.infinity,
  //       //           ),
  //       //           color: Colors.green,
  //       //           child: Column(
  //       //             children: [
  //       //               Text("17:50"),
  //       //             ],
  //       //           ),
  //       //         )
  //       //       ],
  //       //     ),
  //       //   ),
  //       // );
  //       return data.filetype == 1
  //           ? fileshare()
  //           : data.sendme == 0
  //               ? leftsidemessage(data)
  //               : Container(
  //                   child: IntrinsicHeight(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       children: <Widget>[
  //                         Expanded(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.end,
  //                             children: [
  //                               Container(
  //                                   margin: EdgeInsets.only(bottom: 10),
  //                                   constraints: BoxConstraints(maxWidth: 250),
  //                                   alignment: Alignment.centerRight,
  //                                   child: Column(
  //                                     children: [
  //                                       Container(
  //                                           padding: const EdgeInsets.only(
  //                                               left: 10, top: 10, bottom: 10),
  //                                           decoration: const BoxDecoration(
  //                                               color: Color(0xFFFCE7E7),
  //                                               borderRadius: BorderRadius.only(
  //                                                   topLeft:
  //                                                       Radius.circular(10),
  //                                                   bottomLeft:
  //                                                       Radius.circular(10))),
  //                                           child: Text(data.message!)),
  //                                     ],
  //                                   )),
  //                             ],
  //                           ),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.only(bottom: 10, right: 10),
  //                           width: 60,
  //                           child: Stack(
  //                             children: [
  //                               Align(
  //                                 alignment: Alignment.topRight,
  //                                 child: Container(
  //                                   child: Image.asset(
  //                                     'images/message_icon/balloon_outgoing_normal.9.png',
  //                                     height: 30,
  //                                     color: Color(0xFFFCE7E7),
  //                                   ),
  //                                 ),
  //                               ),
  //                               Container(
  //                                 alignment: Alignment.centerLeft,
  //                                 width: 52,
  //                                 color: Color(0xFFFCE7E7),
  //                                 child: Column(
  //                                   mainAxisAlignment: MainAxisAlignment.end,
  //                                   children: [
  //                                     Row(
  //                                       mainAxisSize: MainAxisSize.min,
  //                                       children: [
  //                                         Container(
  //                                             child: Text(
  //                                           data.time!,
  //                                           style: TextStyle(
  //                                               color: Color(0xFFBDADAD)),
  //                                         )),
  //                                         Image.asset(
  //                                           'images/message_icon/message_got_read_receipt_from_target_onmedia.png',
  //                                           height: 15,
  //                                         )
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //     },
  //   );
  // }

  Widget fileshare() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, right: 15),
          height: 100,
          width: 170,
          decoration: BoxDecoration(
              color: Color(0xFFFCE7E7),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                decoration: BoxDecoration(
                    color: Color(0xFFECD9DB),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: const [
                    Icon(Icons.file_download),
                    Text(
                      "IMG_04_75",
                      style: TextStyle(fontSize: 20, color: Color(0xFF474142)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 4),
                    child: Text(
                      "2.4 MB",
                      style: TextStyle(color: Color(0xFF978B8B)),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                        color: Color(0xFF978B8B),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      child: Text(
                    "png",
                    style: TextStyle(color: Color(0xFF978B8B)),
                  )),
                  Spacer(),
                  Text(
                    "10:15",
                    style: TextStyle(color: Color(0xFFBDADAD)),
                  ),
                  Image.asset(
                    'images/message_icon/message_got_read_receipt_from_target_onmedia.png',
                    height: 15,
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  // Widget leftsidemessage(MessageModel data) {
  //   return IntrinsicHeight(
  //     child: Row(
  //       children: [
  //         // Container(
  //         //   alignment: Alignment.centerRight,
  //         //   width: 40,
  //         //   height: double.infinity,
  //         //   child: Stack(
  //         //     alignment: Alignment.centerRight,
  //         //     children: [
  //         //       Container(width: 20, color: Colors.red, child: Text("h")),
  //         //       Align(
  //         //           alignment: Alignment.centerLeft,
  //         //           child: Image.asset(
  //         //               'images/message_icon/balloon_incoming_normal.9.png'))
  //         //     ],
  //         //   ),
  //         // ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Stack(
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.only(left: 7),
  //                   child: Image.asset(
  //                     'images/message_icon/balloon_incoming_normal.9.png',
  //                     height: 25,
  //                     color: Colors.grey[400],
  //                   ),
  //                 ),
  //                 Container(
  //                   padding: EdgeInsets.only(
  //                       left: 10, right: 12, top: 10, bottom: 10),
  //                   decoration: BoxDecoration(
  //                       color: Colors.grey[400],
  //                       borderRadius:
  //                           BorderRadius.only(bottomLeft: Radius.circular(5))),
  //                   margin: EdgeInsets.only(left: 15),
  //                   constraints: BoxConstraints(maxWidth: 250),
  //                   child: Text(data.message!),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         Container(
  //           alignment: Alignment.bottomRight,
  //           height: double.infinity,
  //           margin: EdgeInsets.zero,
  //           padding: EdgeInsets.only(right: 5, bottom: 2),
  //           decoration: BoxDecoration(
  //               color: Colors.grey[400],
  //               borderRadius: BorderRadius.only(
  //                 topRight: Radius.circular(5),
  //                 bottomRight: Radius.circular(5),
  //               )),
  //           child: Text(data.time!),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget leftsidemessage(MessageModel data) {
  //   return Container(
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //             margin: EdgeInsets.only(left: 10),
  //             constraints: BoxConstraints(maxWidth: 200),
  //             decoration: BoxDecoration(
  //                 color: Color(0xFFFAFAFA),
  //                 borderRadius: BorderRadius.only(
  //                   bottomRight: Radius.circular(10),
  //                   topRight: Radius.circular(10),
  //                   bottomLeft: Radius.circular(10),
  //                   topLeft: Radius.circular(10),
  //                 )),
  //             child: Material(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.only(
  //                 bottomRight: Radius.circular(10),
  //                 topRight: Radius.circular(10),
  //                 bottomLeft: Radius.circular(10),
  //                 topLeft: Radius.circular(10),
  //               )),
  //               elevation: 5,
  //               child: Container(
  //                 padding: EdgeInsets.all(10),
  //                 child: Column(
  //                   children: [
  //                     const Text("Do You Know what time is it?"),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       children: [
  //                         Text(
  //                           "17:52",
  //                           style: TextStyle(color: Color(0xFFBDADAD)),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             )),
  //       ],
  //     ),
  //   );
  // }

  Widget leftside(Msg m) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(m.pic!)),
          SizedBox(width: 10),
          Container(
              margin: EdgeInsets.all(2),
              constraints: BoxConstraints(maxWidth: 250),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                m.msg!,
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }

  Widget rigthside(Msg m) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.all(2),
              constraints: BoxConstraints(maxWidth: 250),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.indigo, borderRadius: BorderRadius.circular(5)),
              child: Text(
                m.msg!,
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
