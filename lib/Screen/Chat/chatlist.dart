import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Model/chatlist.dart';
import 'package:jobs_app/Screen/Chat/chatdetails.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';

class ChatListpage extends StatefulWidget {
  const ChatListpage({Key? key}) : super(key: key);

  @override
  _ChatListpageState createState() => _ChatListpageState();
}

class _ChatListpageState extends State<ChatListpage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('login');
    return Scaffold(
      key: _key,
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text('বার্তা সমূহ',
            style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush')),
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "কানেক্ট",
                style: TextStyle(fontFamily: 'Kalpurush', fontSize: 22),
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Mainsearchpage(),
                    ));
              },
              child: Icon(Icons.search)),

          SizedBox(width: 5),
          InkWell(
              onTap: () {
                _key.currentState!.openEndDrawer();
              },
              child: Icon(Icons.menu)),
          SizedBox(width: 10),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: ListView.builder(
        itemCount: chatlist.length,
        itemBuilder: (context, index) {
          var data = chatlist[index];
          return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              color: Color(0xFFF4F4F4),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatdetailsPage(),
                      ));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: data.image,
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data.name!,
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 15,
                                      fontFamily: 'Kalpurush'),
                                ),
                                Spacer(),
                                Text(
                                  data.date!,
                                  style: TextStyle(
                                      color: Color(0xFF919195),
                                      fontFamily: 'Kalpurush'),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            data.audiostatus == 1
                                ? Row(
                                    children: [
                                      Image.asset(
                                        'images/message_icon/recording_mic_pulse.png',
                                        height: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "0:14",
                                        style: TextStyle(
                                            color: Color(0xFF8E8E93),
                                            fontFamily: 'Kalpurush'),
                                      )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      data.seenstatus == 1
                                          ? Image.asset(
                                              'images/message_icon/message_got_read_receipt_from_target_onmedia.png',
                                              height: 20,
                                            )
                                          : Container(),
                                      Text(
                                        data.lastmessage!,
                                        style: TextStyle(
                                            color: Color(0xFF8E8E93),
                                            fontFamily: 'Kalpurush'),
                                      )
                                    ],
                                  )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
