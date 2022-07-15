import 'package:flutter/material.dart';
import 'package:jobs_app/Const_value/apilink.dart';
import 'package:jobs_app/Provider/Profile/profile.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:provider/provider.dart';

import '../../Model/Follow/follow.dart';
import '../../Provider/Follow/follow.dart';
import 'follower.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key? key}) : super(key: key);

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool loading = true;

  Future getfollow() async {
    await Provider.of<FollowProvider>(context, listen: false)
        .followlistin('following');
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
          title: Text("ফলো",
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
            ? Center(child: Text("No Data Found"))
            : ListView.builder(
                itemCount: follow.follow!.msg!.result!.length,
                itemBuilder: (context, index) {
                  var data = follow.follow!.msg!.result![index];
                  return FollowBox(data: data);
                },
              ));
  }
}
