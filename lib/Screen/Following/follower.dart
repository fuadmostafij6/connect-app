import 'package:flutter/material.dart';
import 'package:jobs_app/Provider/Profile/profile.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:provider/provider.dart';

class FollowerPage extends StatefulWidget {
  const FollowerPage({Key? key}) : super(key: key);

  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool loading = false;

  @override
  void initState() {
    loading = true;
    Provider.of<ProfileProvider>(context, listen: false)
        .getfollowing(type: 'follower')
        .then((value) {
      loading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
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
          ? Center(
              child: CircularProgressIndicator(),
            )
          : profile.following == null
              ? Container()
              : Container(
                  child: ListView.builder(
                    itemCount: profile.following!.msg!.result!.length,
                    itemBuilder: (context, index) {
                      var data = profile.following!.msg!.result![index];
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
                                    data.pic != null
                                        ? CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                "https://launch1.goshrt.com/uploads/${data.pic}"),
                                          )
                                        : CircleAvatar(
                                            radius: 40,
                                            backgroundImage: AssetImage(
                                                'images/Chat_list/3.jpg'),
                                          ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.fullName!,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'kalpurush',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        if (data.userName != null)
                                          Text(
                                            data.userName,
                                            style: TextStyle(
                                                fontFamily: 'kalpurush'),
                                          ),
                                        Text(
                                          data.profileTagline!,
                                          style: TextStyle(
                                              fontFamily: 'kalpurush'),
                                        ),
                                        Text(
                                          "সিলিভার মেম্বার",
                                          style: TextStyle(
                                              fontFamily: 'kalpurush',
                                              color: Colors.red),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.red,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "অনুসরুন করুন",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'kalpurush'),
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
                    },
                  ),
                ),
    );
  }
}
