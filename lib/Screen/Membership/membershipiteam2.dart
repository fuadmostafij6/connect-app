import 'package:flutter/material.dart';
import 'package:jobs_app/Screen/Membership/Tab/fivehuntk.dart';
import 'package:jobs_app/Screen/Membership/Tab/hundredtk.dart';
import 'package:jobs_app/Screen/Membership/Tab/threehuntk.dart';
import 'package:jobs_app/Screen/Membership/Tab/zerotk.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';

class Membershipiteam2page extends StatefulWidget {
  const Membershipiteam2page({Key? key}) : super(key: key);

  @override
  _Membershipiteam2pageState createState() => _Membershipiteam2pageState();
}

class _Membershipiteam2pageState extends State<Membershipiteam2page>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  List<Tab> tablist = [
    Tab(
      text: '0৳',
    ),
    Tab(
      text: '100৳',
    ),
    Tab(
      text: '300৳',
    ),
    Tab(
      text: '500৳',
    )
  ];

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MemberShip"),
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: tablist,
          controller: tabController,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Searchpage(),
                    ));
              },
              icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: TabBarView(
        children: [
          Zerotkpage(),
          Hundredtkpage(),
          ThreeHundredtkpage(),
          FiveHundredtkpage()
        ],
        controller: tabController,
      ),
    );
  }
}
