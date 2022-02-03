import 'package:flutter/material.dart';
import 'package:jobs_app/Model/chatlist.dart';
import 'package:jobs_app/Screen/Chat/chatdetails.dart';

class ChatListpage extends StatefulWidget {
  const ChatListpage({Key? key}) : super(key: key);

  @override
  _ChatListpageState createState() => _ChatListpageState();
}

class _ChatListpageState extends State<ChatListpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        shape: RoundedRectangleBorder(
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
        title: const Text(
          "মোঃ হাসান ইসলাম",
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("কানেক্ট"),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Container(
            height: 20,
            child: Text(
              "বার্তা সমূহ",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Searchpage(),
                //     ));
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
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
                                      color: Color(0xFF000000), fontSize: 15),
                                ),
                                Spacer(),
                                Text(
                                  data.date!,
                                  style: TextStyle(color: Color(0xFF919195)),
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
                                        style:
                                            TextStyle(color: Color(0xFF8E8E93)),
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
                                        style:
                                            TextStyle(color: Color(0xFF8E8E93)),
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
