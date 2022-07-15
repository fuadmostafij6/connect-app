import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Const_value/apilink.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/applyjob2.dart';
import 'package:jobs_app/Screen/JobpostDetails/jobpostdetails.dart';
import 'package:jobs_app/Screen/Profile/postlinkuser.dart';
import 'package:provider/provider.dart';

import '../../Model/job_List/joblist.dart';
import '../Linkscreen/mylinkscreen.dart';
import '../VideoPlay/videoplayer.dart';
import '../home/Tab/myfeed.dart';
import 'package:path/path.dart' as path;

class SinglePostView extends StatefulWidget {
  final Msg data;
  final int index;
  const SinglePostView({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<SinglePostView> createState() => _SinglePostViewState();
}

class _SinglePostViewState extends State<SinglePostView> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('login');
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        backgroundColor: Color(0xFFE51D20),
        centerTitle: true,
        title: Text(
          box.get('name'),
          style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush'),
        ),
      ),
      body: SingleChildScrollView(
          child: JobListcard2(data: widget.data, index: widget.index)),
    );
  }
}

class JobListcard2 extends StatefulWidget {
  final Msg data;
  final int index;
  const JobListcard2({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  _JobListcard2State createState() => _JobListcard2State();
}

class _JobListcard2State extends State<JobListcard2> {
  String categoryname = '';
  Offset? tapXY;
  // ↓ hold screen size, using first line in build() method
  RenderBox? overlay;

  RelativeRect get relRectSize =>
      RelativeRect.fromSize(tapXY! & const Size(40, 40), overlay!.size);

  // ↓ get the tap position Offset
  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

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
    overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox?;

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10, top: widget.index == 0 ? 10 : 0),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         SinglePostView(data: widget.data, index: widget.index),
          //   ),
          // );
        },
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
                    "কানেক্ট আইডি: ${widget.data.jobId} ;",
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
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Post: ${difference} day ago by",
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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                widget.data.description!,
                style: TextStyle(fontFamily: 'Kalpurush', color: Colors.black),
              ),
            ),
            widget.data.doc == null
                ? Container()
                : Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.red,
                    child: PageView.builder(
                      itemCount: widget.data.doc!.length,
                      itemBuilder: ((context, index) {
                        var data = widget.data.doc![index];
                        if (path.extension(data) == ".jpg" ||
                            path.extension(data) == ".png" ||
                            path.extension(data) == ".JPG") {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobPostDetailsPage(
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
                                    builder: (context) => JobPostDetailsPage(
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
                              child: PdfView(data: data));
                        } else {
                          return Image.asset(
                            'images/post.jpg',
                            fit: BoxFit.cover,
                          );
                        }
                      }),
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
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ApplyjobPage(
                          //         jobid: widget.data.jobId!,
                          //       ),
                          //     ));
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
      ),
    );
  }
}
