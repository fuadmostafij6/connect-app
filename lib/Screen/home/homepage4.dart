import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Const_value/apilink.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Allcategory/allcategory.dart';
import 'package:jobs_app/Screen/Categoryjob/categoryjob.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:jobs_app/Screen/Searchpage/Tab/searchpage2.dart';
import 'package:jobs_app/Screen/create_Job/createjob.dart';
import 'package:jobs_app/Screen/home/Tab/myfeed.dart';
import 'package:jobs_app/Screen/home/Tab/recentfeed.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Provider/Profile/profile.dart';
import '../Following/follower.dart';
import '../Following/following.dart';
import '../Form/login.dart';
import '../Membership/membershipiteam2.dart';
import '../Profile/profileedit.dart';

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

  bool loading = true;

  void redirectpage(Widget pagename) {
    Navigator.push(context, _createRoute(pagename));
  }

  Route _createRoute(Widget pagename) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pagename,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // const begin = Offset(0.0, 1.0);
        // const end = Offset.zero;
        // const curve = Curves.ease;

        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

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
    final profile = Provider.of<ProfileProvider>(context);
    return Scaffold(
      key: _key,
      endDrawer: DrawerPage(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.red,
            padding: const EdgeInsets.only(left: 5, right: 5),
            margin: const EdgeInsets.only(bottom: 5),
            child: const Text(
              "নতুন লিংক",
              style: TextStyle(fontFamily: 'Kalpurush', color: Colors.white),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateJobpage(),
                  ));
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        backgroundColor: const Color(0xFFE51D20),
        title: Text(
          box.get('name'),
          style: const TextStyle(fontSize: 16, fontFamily: 'Kalpurush'),
        ),
        centerTitle: true,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(10),
        //       bottomRight: Radius.circular(10)),
        // ),
        // bottom: const PreferredSize(
        //     preferredSize: Size.fromHeight(20.0),
        //     child: Text(
        //       "হোমপেজ",
        //       style: TextStyle(
        //           color: Colors.white, fontFamily: 'Kalpurush', fontSize: 14),
        //     )),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                "কানেক্ট",
                maxLines: 1,
                style: TextStyle(fontFamily: 'Kalpurush', fontSize: 22),
              ),
            ),
          ],
        ),
        leadingWidth: 100,

        // leading: MaterialButton(
        //   minWidth: 20,
        //   onPressed: () {},
        //   child: Text(
        //     "কানেক্ট",
        //     style: TextStyle(fontFamily: 'Kalpurush', fontSize: 22),
        //   ),
        // ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Mainsearchpage(),
                    ));
              },
              child: const Icon(Icons.search)),

          const SizedBox(width: 5),
          InkWell(
              onTap: () {
                _key.currentState!.openEndDrawer();
              },
              child: Icon(Icons.menu)),
          SizedBox(width: 10),
          // IconButton(
          //     onPressed: () {
          //       _key.currentState!.openEndDrawer();
          //     },
          //     icon: Icon(Icons.menu)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // categorybox(),
                  Container(
                    child: categorybox2(),
                    color: Colors.grey[300],
                  ),
                  // tabbarbox(),
                  Myfeedpage()
                ],
              ),
            ),
    );
  }

  // Widget categorybox() {
  //   final homeprovider = Provider.of<HomeProvider>(context);
  //   Size size = MediaQuery.of(context).size;
  //   return Container(
  //     width: double.infinity,
  //     color: Colors.transparent,
  //     child: Column(
  //       children: [
  //         // Row(
  //         //   mainAxisAlignment: MainAxisAlignment.end,
  //         //   children: [
  //         //     InkWell(
  //         //       onTap: () {
  //         //         Navigator.push(
  //         //             context,
  //         //             MaterialPageRoute(
  //         //               builder: (context) => Allcategorypage(),
  //         //             ));
  //         //       },
  //         //       child: Container(
  //         //           margin: EdgeInsets.only(bottom: 1),
  //         //           child: Text("View All")),
  //         //     )
  //         //   ],
  //         // ),
  //         Container(
  //           height: size.height * 0.11,
  //           color: Colors.transparent,
  //           child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: homeprovider.categorylist!.msg!.length,
  //             itemBuilder: (context, index) {
  //               var data = homeprovider.categorylist!.msg![index];
  //               return Card(
  //                 color: Colors.transparent,
  //                 child: InkWell(
  //                   onTap: () {
  //                     print(data.catId);
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => CategoryjobPage(
  //                             categoryid: data.catId!,
  //                             categoryname: data.catName!,
  //                           ),
  //                         ));
  //                   },
  //                   child: Container(
  //                     width: size.width * 0.3,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(5),
  //                         gradient: LinearGradient(
  //                             colors: [Color(0xFFE51D20), Color(0xFFE51D20)],
  //                             begin: Alignment.topLeft,
  //                             end: Alignment.bottomRight)),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         SizedBox(height: 4),
  //                         SvgPicture.asset(
  //                           'images/svg/compact-disc-solid.svg',
  //                           height: 45,
  //                           color: Colors.white,
  //                         ),
  //                         Text(
  //                           data.catName!,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                               color: Colors.white, fontFamily: 'Kalpurush'),
  //                         ),
  //                         // SizedBox(height: 5),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget categorybox2() {
    final homeprovider = Provider.of<HomeProvider>(context);
    return Card(
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemCount: homeprovider.allcategory!.msg!.length,
          itemBuilder: (BuildContext context, int index) {
            var data = homeprovider.allcategory!.msg![index];
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryjobPage(
                                categoryid: data.catId!,
                                categoryname: data.catName!),
                          ));
                    },
                    child: Column(
                      children: [
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                categoryImage + data.image!,
                                fit: BoxFit.cover,
                              ),
                            )),
                        const SizedBox(height: 5),
                        Text(data.catName!,
                            maxLines: 1,
                            style: const TextStyle(fontFamily: 'Kalpurush')),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
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
            "My Feed",
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
        ),
        Tab(
          child: Text(
            "Recent Feed",
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
        )
      ],
    );
  }

  // Widget tabbarview() {
  //   return TabBarView(controller: tabController, children: [
  //     Myfeedpage(),
  //     Recentfeedpage(),
  //   ]);
  // }
}
