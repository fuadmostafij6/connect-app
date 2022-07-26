import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs_app/Const_value/apilink.dart';
import 'package:jobs_app/Provider/Search/search.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/apply_job.dart';
import 'package:jobs_app/Screen/Apply_job/applyjob2.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/home/Tab/recentfeed.dart';
import 'package:provider/provider.dart';
import 'package:jobs_app/Model/Search_Job/searchjob.dart';

import '../../JobpostDetails/jobpostdetails.dart';
import '../../Linkscreen/mylinkscreen.dart';
import '../../VideoPlay/videoplayer.dart';
import '../../create_Job/audioplay.dart';
import '../../home/Tab/myfeed.dart';
import 'package:path/path.dart' as path;

class Searchpage2 extends StatefulWidget {
  const Searchpage2({Key? key}) : super(key: key);

  @override
  _Searchpage2State createState() => _Searchpage2State();
}

class _Searchpage2State extends State<Searchpage2> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final search = Provider.of<Searchprovider>(context);
    return Scaffold(
      // key: _key,
      // endDrawer: DrawerPage(),
      // appBar: AppBar(
      //   title: Text('সার্চ',
      //       style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush')),
      //   elevation: 0,
      //   flexibleSpace: const Image(
      //     image: AssetImage(
      //       'images/Top Bar illustration Solid.png',
      //     ),
      //     fit: BoxFit.cover,
      //   ),
      //   backgroundColor: Color(0xFFE51D20),
      //   centerTitle: true,
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: Icon(Icons.arrow_back)),
      //   actions: [
      //     // IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      //     IconButton(
      //         onPressed: () {
      //           _key.currentState!.openEndDrawer();
      //         },
      //         icon: Icon(Icons.menu)),
      //   ],
      // ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            // searchpage(),
            search.searchJob != null
                ? Flexible(child: alllinkservice())
                : Container(),
          ],
        ),
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
            search.getsearchjob(keyword: value, context: context).then((value) {
              search
                  .getsearchuser(context: context, keyword: value, type: 2)
                  .then((value) {
                search.getsearchcategory(
                    context: context, keyword: value, type: 3);
              });
            });
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            hintText: "সার্চ করুন",
            hintStyle: TextStyle(fontFamily: 'Kalpurush')),
      ),
    );
  }

  Widget alllinkservice() {
    final search = Provider.of<Searchprovider>(context);
    return search.searchJob!.msg!.isEmpty
        ? Center(
            child: Text("No Job Found"),
          )
        : ListView.builder(
            itemCount: search.searchJob!.msg!.length,
            itemBuilder: (context, index) {
              var data = search.searchJob!.msg![index];
              return JobListcard(
                index: index,
                data: data,
              );
            },
          );
  }
}

class JobListcard extends StatefulWidget {
  final Msg data;
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

    final player = AudioPlay();



  @override
  void initState() {
    player.playaudioinit();
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
                      fontFamily: 'Kalpurush', color: Colors.grey[700]),
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
           
                widget.data.doc == null
                      ? Container()
                      : Container(
                          height: 160,
                          width: double.infinity,
                          child: PageView.builder(
                            itemCount: widget.data.doc!.length,
                            itemBuilder: ((context, index) {
                              var data = widget.data.doc![index];
                              if (path.extension(data) == ".jpg" ||
                                  path.extension(data) == ".png" ||
                                  path.extension(data) == ".JPG" ||
                                  path.extension(data) == ".jpeg") {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            JobPostDetailsPage(
                                          doc: data,
                                          descripton: widget.data.description!,
                                          id: widget.data.jobId!,
                                          jobtitle: widget.data.jobTitle!,
                                          username: widget.data.createdByName!,
                                          catgeoryname: widget.data.category!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Image.network(
                                      jobimage + data,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              } else if (path.extension(data) == ".mp4") {
                                return ChewieDemo(
                                  videourl: jobimage + data,
                                );
                              } else if (path.extension(data) == ".pdf") {
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              JobPostDetailsPage(
                                            doc: data,
                                            descripton:
                                                widget.data.description!,
                                            id: widget.data.jobId!,
                                            jobtitle: widget.data.jobTitle!,
                                            username:
                                                widget.data.createdByName!,
                                            catgeoryname: widget.data.category!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: PdfView(data: data));
                              } else if (path.extension(data) == ".aac") {
                                print(jobimage + data);
                                return Container(
                                  child: IconButton(
                                      onPressed: () async {
                                        await player.toogleaudioplayer(
                                          whenfinish: () {
                                            setState(() {});
                                          },
                                          path: jobimage + data
                                        );
                                        // playaudio(jobimage + data);
                                      },
                                      icon: Icon(Icons.mic)),
                                );
                              } else {
                                return Image.asset(
                                  'images/post.jpg',
                                  fit: BoxFit.cover,
                                );
                              }
                            }),
                          ),
                        )
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
                                  username: widget.data.createdByName!, image: widget.data.doc![0],),
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
