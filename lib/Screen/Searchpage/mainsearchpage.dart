import 'package:flutter/material.dart';
import 'package:jobs_app/Provider/Search/search.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage2.dart';
import 'package:jobs_app/Screen/home/Tab/recentfeed.dart';
import 'package:provider/provider.dart';

class Mainsearchpage extends StatefulWidget {
  const Mainsearchpage({Key? key}) : super(key: key);

  @override
  _MainsearchpageState createState() => _MainsearchpageState();
}

class _MainsearchpageState extends State<Mainsearchpage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: DrawerPage(),
      appBar: AppBar(
        title: Text('সার্চ',
            style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush')),
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        backgroundColor: Color(0xFFE51D20),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
              icon: Icon(Icons.menu)),
        ],
      ),
      body: Column(
        children: [searchpage(), tabbarbox(), Flexible(child: tabbarview())],
      ),
    );
  }

  Widget searchpage() {
    final search = Provider.of<Searchprovider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        onChanged: (value) {
          if (value.isNotEmpty) {
            search
                .getsearchjob(keyword: value, context: context)
                .then((value) {});
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            hintText: "সার্চ করুন",
            hintStyle: TextStyle(fontFamily: 'Kalpurush')),
      ),
    );
  }

  Widget tabbarbox() {
    return TabBar(
      labelColor: Colors.red,
      indicatorColor: Colors.red,
      unselectedLabelColor: Colors.black,
      controller: tabController,
      tabs: const [
        Tab(
          child: Text(
            "লিংক",
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
        ),
        Tab(
          child: Text(
            "পিপল",
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
        ),
        Tab(
          child: Text(
            "ক্যাটাগরি",
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
        )
      ],
    );
  }

  Widget tabbarview() {
    return TabBarView(controller: tabController, children: [
      Searchpage2(),
      Container(
        height: 300,
        alignment: Alignment.center,
        child: Text("No people Found"),
      ),
      Container(
        height: 300,
        alignment: Alignment.center,
        child: Text("No category Found"),
      ),
    ]);
  }
}
