import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs_app/Model/Userjob/userjob.dart';

import 'package:jobs_app/Provider/Userjob/userjob.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/apply_job.dart';
import 'package:jobs_app/Screen/Apply_job/applyjob2.dart';

import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/home/Tab/myfeed.dart';
import 'package:provider/provider.dart';
import 'package:jobs_app/Model/SearchUser/searchuser.dart';

class Linkuserprofile extends StatefulWidget {
  final Msg data;
  const Linkuserprofile({Key? key, required this.data}) : super(key: key);

  @override
  _LinkuserprofileState createState() => _LinkuserprofileState();
}

class _LinkuserprofileState extends State<Linkuserprofile> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool loading = false;

  @override
  void initState() {
    loading = true;
    Provider.of<Userjobpage>(context, listen: false)
        .getuserjob(userid: widget.data.userId)
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
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush')),
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        flexibleSpace: Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
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
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
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
                                        backgroundImage: NetworkImage(
                                            "https://launch1.goshrt.com/uploads/${widget.data.pic}"),
                                      )
                                    : CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage(
                                            'images/Chat_list/3.jpg'),
                                      ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.data.fullName!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'kalpurush',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (widget.data.userName != null)
                                      Text(
                                        widget.data.userName,
                                        style:
                                            TextStyle(fontFamily: 'kalpurush'),
                                      ),
                                    Text(
                                      widget.data.profileTagline!,
                                      style: TextStyle(fontFamily: 'kalpurush'),
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
                          Divider(),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "যোগাযোগঃ ",
                              style: TextStyle(
                                  fontFamily: 'kalpurush', fontSize: 17),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Icon(Icons.email, size: 17),
                                SizedBox(width: 5),
                                Text(
                                  widget.data.email ?? '',
                                  style: TextStyle(fontFamily: 'kalpurush'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Icon(Icons.phone, size: 17),
                                SizedBox(width: 5),
                                Text(
                                  widget.data.phone ?? '',
                                  style: TextStyle(fontFamily: 'kalpurush'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          "${widget.data.fullName} এর প্রস্তাবিত লিংক সমুহ: ",
                          style:
                              TextStyle(fontFamily: 'kalpurush', fontSize: 18)),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: userjob.userjob!.msg!.length,
                      itemBuilder: (context, index) {
                        var data = userjob.userjob!.msg![index];
                        return JobListcard(
                          data: data,
                          index: index,
                        );
                      },
                    ),
                  ],
                ),
              ),
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
    for (var i = 0; i < homeprovider.allcategory!.msg!.length; i++) {
      if (widget.data.category == homeprovider.allcategory!.msg![i].catId) {
        setState(() {
          categoryname = homeprovider.allcategory!.msg![i].catName!;
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
                Text(
                  widget.data.createdByName!,
                  style: TextStyle(
                      fontFamily: 'Kalpurush',
                      color: Colors.red.withOpacity(0.7)),
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
                                  username: widget.data.createdByName!, image: widget.data.doc![0],
                              ),
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
                                    'images/svg/check-solid.svg',
                                    height: 15,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "প্রস্তাবনা দিন",
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
