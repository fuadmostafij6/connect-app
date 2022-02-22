import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:jobs_app/Model/Userjob/userjob.dart';
import 'package:jobs_app/Provider/Userjob/userjob.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/apply_job.dart';
import 'package:jobs_app/Screen/Linkscreen/applicationlist.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:jobs_app/Screen/Searchpage/Tab/searchpage2.dart';
import 'package:jobs_app/Screen/home/Tab/recentfeed.dart';
import 'package:provider/provider.dart';

import '../Apply_job/applyjob2.dart';
import '../Profile/postlinkuser.dart';
import '../create_Job/createjob.dart';
import '../home/Tab/myfeed.dart';

class MylinkListPage extends StatefulWidget {
  const MylinkListPage({Key? key}) : super(key: key);

  @override
  _MylinkListPageState createState() => _MylinkListPageState();
}

class _MylinkListPageState extends State<MylinkListPage> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    var box = Hive.box('login');
    loading = true;
    Provider.of<Userjobpage>(context, listen: false)
        .getuserjob(userid: box.get('userid'))
        .then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userjob = Provider.of<Userjobpage>(context);
    return Scaffold(
      key: _key,
      endDrawer: DrawerPage(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "নতুন লিংক",
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
          FloatingActionButton(
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
        ],
      ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('আমার লিংক সমূহ',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("কানেক্ট",
                  style: TextStyle(fontFamily: 'Kalpurush', fontSize: 22)),
            ),
          ],
        ),
        leadingWidth: 70,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(30.0),
        //   child: Container(
        //     height: 20,
        //     child: Text(
        //       "আমার লিংক সমূহ",
        //       style: TextStyle(color: Colors.white),
        //     ),
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
              child: Icon(Icons.search)),
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const Searchpage(),
          //           ));
          //     },
          //     icon: Icon(Icons.search)),
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
      body: userjob.userjob == null || userjob.userjob!.msg!.isEmpty
          ? Center(
              child: Text("No Job"),
            )
          : ListView.builder(
              itemCount: userjob.userjob!.msg!.length,
              itemBuilder: (context, index) {
                var data = userjob.userjob!.msg![index];
                return JobListcard(
                  data: data,
                  index: index,
                );
              },
            ),
    );
  }
}

class JobListcard extends StatefulWidget {
  final Msgs data;
  final int index;
  const JobListcard({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  _JobListcardState createState() => _JobListcardState();
}

class _JobListcardState extends State<JobListcard> {
  String categoryname = '';

  void categorynamefind() {
    final homeprovider = Provider.of<HomeProvider>(context, listen: false);
    for (var i = 0; i < homeprovider.categorylist!.msg!.length; i++) {
      if (widget.data.category == homeprovider.categorylist!.msg![i].catId) {
        setState(() {
          categoryname = homeprovider.categorylist!.msg![i].catName!;
        });
      }
    }
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  void initState() {
    categorynamefind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime birthday = DateTime(widget.data.createdAt!.year,
        widget.data.createdAt!.month, widget.data.createdAt!.day);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10, top: widget.index == 0 ? 10 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: Text(
              widget.data.jobTitle!,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kalpurush'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  "কানেক্ট আইডি: ${widget.data.jobId}",
                  style: TextStyle(
                      fontFamily: 'Kalpurush', color: Colors.grey[700]),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostLinkuserprofile(
                            userid: widget.data.createdBy!,
                          ),
                        ));
                  },
                  child: Text(
                    widget.data.createdByName!,
                    style: TextStyle(
                        fontFamily: 'Kalpurush',
                        color: Colors.red.withOpacity(0.7)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  "Post: ${difference} day ago",
                  style: TextStyle(
                      fontFamily: 'Kalpurush', color: Colors.grey[700]),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    widget.data.category!,
                    style: TextStyle(
                        fontFamily: 'Kalpurush', color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              widget.data.description!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: 'Kalpurush', color: Colors.black),
            ),
          ),
          Container(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ImagedialogBox(),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('images/post.jpg'),
                ],
              ),
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Flexible(
                //   child: Material(
                //     color: Colors.transparent,
                //     child: InkWell(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => ApplyjobPage(
                //                 jobid: widget.data.jobId!,
                //               ),
                //             ));
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(9),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Container(
                //               child: Row(
                //                 children: [
                //                   SvgPicture.asset(
                //                     'images/svg/pen-solid.svg',
                //                     height: 15,
                //                     color: Colors.grey[700],
                //                   ),
                //                   SizedBox(width: 5),
                //                   Text(
                //                     "এডিট করুন",
                //                     style: TextStyle(
                //                         fontFamily: 'Kalpurush',
                //                         color: Colors.grey[700]),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.grey[300],
                //   width: 1,
                //   child: VerticalDivider(
                //     color: Colors.black,
                //     thickness: 3,
                //     indent: 20,
                //     endIndent: 0,
                //     width: 1,
                //   ),
                // ),
                Flexible(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Applyjob2Page(
                                  connectid: widget.data.jobId!,
                                  id: widget.data.jobId!,
                                  tile: widget.data.jobTitle!,
                                  username: widget.data.createdByName!),
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'images/svg/user-solid.svg',
                                    height: 15,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "প্রার্থী",
                                    style: TextStyle(
                                        fontFamily: 'Kalpurush',
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  width: 1,
                  child: VerticalDivider(
                    color: Colors.black,
                    thickness: 3,
                    indent: 20,
                    endIndent: 0,
                    width: 1,
                  ),
                ),
                // Flexible(
                //   child: Material(
                //     color: Colors.transparent,
                //     child: InkWell(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => ApplyjobPage(
                //                 jobid: widget.data.jobId!,
                //               ),
                //             ));
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(9),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Container(
                //               child: Row(
                //                 children: [
                //                   SvgPicture.asset(
                //                     'images/svg/xmark-solid.svg',
                //                     height: 15,
                //                     color: Colors.grey[700],
                //                   ),
                //                   SizedBox(width: 5),
                //                   Text(
                //                     "রিমোভ করুন",
                //                     style: TextStyle(
                //                         fontFamily: 'Kalpurush',
                //                         color: Colors.grey[700]),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.grey[300],
                //   width: 1,
                //   child: VerticalDivider(
                //     color: Colors.black,
                //     thickness: 3,
                //     indent: 20,
                //     endIndent: 0,
                //     width: 1,
                //   ),
                // ),
                Flexible(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        share();
                      },
                      child: Container(
                        padding: EdgeInsets.all(9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Row(
                              children: [
                                SvgPicture.asset(
                                  'images/svg/share-solid.svg',
                                  height: 15,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 5),
                                Text("শেয়ার",
                                    style: TextStyle(
                                        fontFamily: 'Kalpurush',
                                        color: Colors.grey[700])),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  color: Colors.grey[300],
                  width: 1,
                  child: VerticalDivider(
                    color: Colors.black,
                    thickness: 3,
                    indent: 20,
                    endIndent: 0,
                    width: 1,
                  ),
                ),
                Flexible(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 35,

                        child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'images/svg/xmark-solid.svg',
                                    height: 15,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "রিমোভ করুন",
                                    style: TextStyle(
                                        fontFamily: 'Kalpurush',
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              )),
                              PopupMenuItem(
                                  child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'images/svg/pen-solid.svg',
                                    height: 15,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "এডিট করুন",
                                    style: TextStyle(
                                        fontFamily: 'Kalpurush',
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ))
                            ];
                          },
                        ),
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //         child: Row(
                        //       children: [
                        //         Icon(Icons.more_vert_outlined),
                        //         SizedBox(width: 5),
                        //         Text("আরো",
                        //             style: TextStyle(
                        //                 fontFamily: 'Kalpurush',
                        //                 color: Colors.grey[700])),
                        //       ],
                        //     )),
                        //   ],
                        // ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
