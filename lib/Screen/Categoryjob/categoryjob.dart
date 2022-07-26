import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs_app/Model/job_List/joblist.dart';
import 'package:jobs_app/Provider/Categorybyjob/categoryjob.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/apply_job.dart';
import 'package:jobs_app/Screen/Linkscreen/applicationlist.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/home/Tab/recentfeed.dart';
import 'package:provider/provider.dart';

import '../../Const_value/apilink.dart';
import '../Apply_job/applyjob2.dart';
import '../JobpostDetails/jobpostdetails.dart';
import '../Linkscreen/mylinkscreen.dart';
import '../VideoPlay/videoplayer.dart';
import '../create_Job/audioplay.dart';
import '../home/Tab/myfeed.dart';
import 'package:path/path.dart' as path;
class CategoryjobPage extends StatefulWidget {
  final String categoryid, categoryname;
  const CategoryjobPage(
      {Key? key, required this.categoryid, required this.categoryname})
      : super(key: key);

  @override
  _CategoryjobPageState createState() => _CategoryjobPageState();
}

class _CategoryjobPageState extends State<CategoryjobPage> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    loading = true;
    Provider.of<CategoryJobprovider>(context, listen: false)
        .getcategoryjob(widget.categoryid)
        .then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryjob = Provider.of<CategoryJobprovider>(context);
    return Scaffold(
      key: _key,
      endDrawer: DrawerPage(),
      appBar: AppBar(
        title: Text(
          widget.categoryname,
          style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush'),
        ),
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
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
          : Container(
              color: Colors.grey[300],
              child: categoryjob.joblist == null
                  ? Center(
                      child: Text("No Job Found"),
                    )
                  : ListView.builder(
                      itemCount: categoryjob.joblist!.msg!.length,
                      itemBuilder: (context, index) {
                        var data = categoryjob.joblist!.msg![index];
                        return JobListcard(
                          data: data,
                          index: index,
                        );
                      },
                    ),
            ),
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
        title: widget.data.jobTitle!,
        text: widget.data.description!,
        linkUrl: widget.data.sharelink,
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
                      fontFamily: 'Kalpurush',
                      color: Colors.red.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  "Post: $difference day ago",
                  style: TextStyle(
                      fontFamily: 'Kalpurush', color: Colors.grey[700]),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              widget.data.description!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Kalpurush', color: Colors.black),
            ),
          ),

          Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                widget.data.doc == null
                    ? Container()
                    : ListView.builder(
                  primary: false,
                  shrinkWrap: true,

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
                        child: Image.network(
                          jobimage + data,
                          fit: BoxFit.cover,
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
                                  path: jobimage + data);
                              // playaudio(jobimage + data);
                            },
                            icon: const Icon(Icons.mic)),
                      );
                    } else {
                      return Image.asset(
                        'images/post.jpg',
                        fit: BoxFit.cover,
                      );
                    }
                  }),
                )
                // : Container(
                //     height: 160,
                //     width: double.infinity,

                //     child: PageView.builder(
                //       itemCount: widget.data.doc!.length,
                //       itemBuilder: ((context, index) {
                //         var data = widget.data.doc![index];
                //         if (path.extension(data) == ".jpg" ||
                //             path.extension(data) == ".png" ||
                //             path.extension(data) == ".JPG") {
                //           return InkWell(
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                   builder: (context) =>
                //                       JobPostDetailsPage(
                //                     doc: data,
                //                     descripton: widget.data.description!,
                //                     id: widget.data.jobId!,
                //                     jobtitle: widget.data.jobTitle!,
                //                     username: widget.data.createdByName!,
                //                     catgeoryname: widget.data.category!,
                //                   ),
                //                 ),
                //               );
                //             },
                //             child: Container(
                //               child: Image.network(
                //                 jobimage + data,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           );
                //         } else if (path.extension(data) == ".mp4") {
                //           return ChewieDemo(
                //             videourl: jobimage + data,
                //           );
                //         } else if (path.extension(data) == ".pdf") {
                //           return InkWell(
                //               onTap: () {
                //                 Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                     builder: (context) =>
                //                         JobPostDetailsPage(
                //                       doc: data,
                //                       descripton:
                //                           widget.data.description!,
                //                       id: widget.data.jobId!,
                //                       jobtitle: widget.data.jobTitle!,
                //                       username:
                //                           widget.data.createdByName!,
                //                       catgeoryname: widget.data.category!,
                //                     ),
                //                   ),
                //                 );
                //               },
                //               child: PdfView(data: data));
                //         } else if (path.extension(data) == ".aac") {
                //             return Container(

                //               child: IconButton(
                //                   onPressed: () {
                //                     playaudio(jobimage + data);
                //                   },
                //                   icon: Icon(Icons.mic)),
                //             );
                //           } else {
                //           return Image.asset(
                //             'images/post.jpg',
                //             fit: BoxFit.cover,
                //           );
                //         }
                //       }),
                //     ),
                //   )
              ],
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
                                  username: widget.data.createdBy!, image: widget.data.doc![0],),
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(9),
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
                  child: const VerticalDivider(
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
