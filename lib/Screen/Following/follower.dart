import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Const_value/apilink.dart';
import 'package:jobs_app/Provider/Profile/profile.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:provider/provider.dart';

import '../../Model/Follow/follow.dart';
import '../../Provider/Follow/follow.dart';
import 'package:http/http.dart' as http;

class FollowerPage extends StatefulWidget {
  const FollowerPage({Key? key}) : super(key: key);

  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool loading = true;

  Future getfollow() async {
    await Provider.of<FollowProvider>(context, listen: false)
        .followlistin('follower');
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getfollow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final follow = Provider.of<FollowProvider>(context);
    return Scaffold(
        // key: _key,
        // endDrawer: DrawerPage(),
        appBar: AppBar(
          title: Text("ফলোয়ার",
              style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush')),
          elevation: 0,
          flexibleSpace: const Image(
            image: AssetImage(
              'images/Top Bar illustration Solid.png',
            ),
            fit: BoxFit.cover,
          ),
          backgroundColor: const Color(0xFFE51D20),
          centerTitle: true,
          // leading: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.only(left: 10),
          //       child: Text(
          //         "কানেক্ট",
          //         style: TextStyle(fontFamily: 'Kalpurush', fontSize: 22),
          //       ),
          //     ),
          //   ],
          // ),
          leadingWidth: 70,
          // actions: [
          //   InkWell(
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => const Mainsearchpage(),
          //             ));
          //       },
          //       child: Icon(Icons.search)),
          //   // IconButton(
          //   //     onPressed: () {
          //   //       Navigator.push(
          //   //           context,
          //   //           MaterialPageRoute(
          //   //             builder: (context) => const Searchpage(),
          //   //           ));
          //   //     },
          //   //     icon: Icon(Icons.search)),
          //   SizedBox(width: 5),
          //   InkWell(
          //       onTap: () {
          //         _key.currentState!.openEndDrawer();
          //       },
          //       child: Icon(Icons.menu)),
          //   SizedBox(width: 10),
          //   // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          // ],
        ),
        body: loading
            ? Center(child: Text("No data Found"))
            : Container(
                child: ListView.builder(
                  itemCount: follow.follow!.msg!.result!.length,
                  itemBuilder: (context, index) {
                    var data = follow.follow!.msg!.result![index];
                    return FollowBox(data: data);
                  },
                ),
              ));
  }
}

class FollowBox extends StatefulWidget {
  final Result data;
  const FollowBox({Key? key, required this.data}) : super(key: key);

  @override
  State<FollowBox> createState() => _FollowBoxState();
}

class _FollowBoxState extends State<FollowBox> {
  String? status = '';

  Future followstatus() async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=8b60b892cb6cdac140e0edd7f17a76733b8087b3'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/api/follow/followstatus?user_id=${box.get('userid')}&user_profile_id=${widget.data.userId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      setState(() {
        status = json['msg'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    followstatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final follow = Provider.of<FollowProvider>(context);
    return Container(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.data.pic != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(otherimage + widget.data.pic!),
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('images/Chat_list/3.jpg'),
                        ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.fullName ?? "",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'kalpurush',
                            fontWeight: FontWeight.bold),
                      ),
                      if (widget.data.userName != null)
                        Text(
                          widget.data.userName ?? "",
                          style: TextStyle(fontFamily: 'kalpurush'),
                        ),
                      Text(
                        widget.data.profileTagline ?? "",
                        style: TextStyle(fontFamily: 'kalpurush'),
                      ),
                      // Text(
                      //   data.profileTagline ?? "",
                      //   style: TextStyle(
                      //       fontFamily: 'kalpurush',
                      //       color: Colors.red),
                      // ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              if (status == "User can follow this user") {
                                follow
                                    .followacton(
                                        profileid:
                                            widget.data.userId.toString(),
                                        status: 'add')
                                    .then((value) => followstatus());
                              } else {
                                follow
                                    .followacton(
                                        profileid:
                                            widget.data.userId.toString(),
                                        status: 'remove')
                                    .then((value) => followstatus());
                              }
                            },
                            child: Text(
                              status == ""
                                  ? ""
                                  : status == "User can follow this user"
                                      ? "অনুসরুন করুন"
                                      : "অনুসরুন বাতিল করুন",
                              style: TextStyle(
                                  color: Colors.red, fontFamily: 'kalpurush'),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            // Divider(),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   child: Text(
            //     "যোগাযোগঃ ",
            //     style: TextStyle(
            //         fontFamily: 'kalpurush', fontSize: 17),
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     children: [
            //       Icon(Icons.email, size: 17),
            //       SizedBox(width: 5),
            //       Text(
            //         widget.data.email ?? '',
            //         style: TextStyle(fontFamily: 'kalpurush'),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     children: [
            //       Icon(Icons.phone, size: 17),
            //       SizedBox(width: 5),
            //       Text(
            //         widget.data.phone ?? '',
            //         style: TextStyle(fontFamily: 'kalpurush'),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
