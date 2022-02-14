import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Allcategory/allcategory.dart';
import 'package:jobs_app/Screen/Categoryjob/categoryjob.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:jobs_app/Screen/create_Job/createjob.dart';
import 'package:jobs_app/Screen/home/Tab/recentfeed.dart';
import 'package:provider/provider.dart';

class Homepage4 extends StatefulWidget {
  const Homepage4({Key? key}) : super(key: key);

  @override
  _Homepage4State createState() => _Homepage4State();
}

class _Homepage4State extends State<Homepage4> with TickerProviderStateMixin {
  TabController? tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Future loaddata() async {
    await Provider.of<HomeProvider>(context, listen: false).getcategorylist();
    await Provider.of<HomeProvider>(context, listen: false).getjoblist();
  }

  bool loading = false;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    loading = true;
    loaddata().then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('login');
    return Scaffold(
      key: _key,
      endDrawer: DrawerPage(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateJobpage(),
              ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        backgroundColor: Color(0xFFE51D20),
        title: Text(
          box.get('name'),
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(10),
        //       bottomRight: Radius.circular(10)),
        // ),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: Text(
              "হোমপেজ",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Kalpurush', fontSize: 17),
            )),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "কানেক্ট",
              style: TextStyle(fontFamily: 'Kalpurush'),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Searchpage(),
                    ));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
              icon: Icon(Icons.menu)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                categorybox(),
                tabbarbox(),
                Flexible(child: tabbarview())
              ],
            ),
    );
  }

  Widget categorybox() {
    final homeprovider = Provider.of<HomeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Allcategorypage(),
                        ));
                  },
                  child: Container(
                      margin: EdgeInsets.only(bottom: 1),
                      child: Text("View All")),
                )
              ],
            ),
            Container(
              height: size.height * 0.11,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeprovider.categorylist!.msg!.length,
                itemBuilder: (context, index) {
                  var data = homeprovider.categorylist!.msg![index];
                  return InkWell(
                    onTap: () {
                      print(data.catId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryjobPage(
                              categoryid: data.catId!,
                              categoryname: data.catName!,
                            ),
                          ));
                    },
                    child: Container(
                      width: size.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 1),
                            height: size.height * 0.08,
                            width: size.width * 0.3,
                            child: Image.asset(
                              'images/download.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            data.catName!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabbarbox() {
    return TabBar(
      controller: tabController,
      tabs: const [
        Tab(
          child: Text(
            "My Feed",
            style: TextStyle(color: Colors.black),
          ),
        ),
        Tab(
          child: Text(
            "Recent Feed",
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }

  Widget tabbarview() {
    return TabBarView(controller: tabController, children: [
      Container(
        child: Text("No Feed"),
      ),
      Recentfeedpage(),
    ]);
  }
}