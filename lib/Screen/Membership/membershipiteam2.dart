import 'package:flutter/material.dart';

import 'package:jobs_app/Screen/Membership/Tab/zerotk.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:provider/provider.dart';

import '../../Provider/MemberPackage/memberpackage.dart';

class Membershipiteam2page extends StatefulWidget {
  const Membershipiteam2page({Key? key}) : super(key: key);

  @override
  _Membershipiteam2pageState createState() => _Membershipiteam2pageState();
}

class _Membershipiteam2pageState extends State<Membershipiteam2page>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  List<Tab> tablist = [];

  Future getpackagelist() async {
    final package = Provider.of<PackageProvider>(context, listen: false);
    tablist = List.generate(package.memebrpackagelist!.msg!.length, (index) {
      var data = package.memebrpackagelist!.msg![index];
      return Tab(text: data.price);
    });
    tabController = TabController(length: tablist.length, vsync: this);
  }

  bool loading = true;

  @override
  void initState() {
    getpackagelist();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final package = Provider.of<PackageProvider>(context, listen: false);
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
                      builder: (context) => Mainsearchpage(),
                    ));
              },
              icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: TabBarView(
        children:
            List.generate(package.memebrpackagelist!.msg!.length, (index) {
          return Zerotkpage(
            msg: package.memebrpackagelist!.msg![index],
          );
        }),
        controller: tabController,
      ),
    );
  }
}
