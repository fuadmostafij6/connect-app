import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jobs_app/Model/job_List/joblist.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/apply_job.dart';
import 'package:jobs_app/Screen/Apply_job/applyjob2.dart';
import 'package:jobs_app/Screen/Profile/postlinkuser.dart';
import 'package:jobs_app/Screen/Singlepostview/singlepostview.dart';
import 'package:provider/provider.dart';

import '../../../Const_value/apilink.dart';
import '../../JobpostDetails/jobpostdetails.dart';

class Myfeedpage extends StatefulWidget {
  const Myfeedpage({Key? key}) : super(key: key);

  @override
  _MyfeedpageState createState() => _MyfeedpageState();
}

class _MyfeedpageState extends State<Myfeedpage> {
  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomeProvider>(context);
    return Container(
      color: Colors.grey[300],
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: homeprovider.joblist!.msg!.length,
        itemBuilder: (context, index) {
          var data = homeprovider.joblist!.msg![index];
          return JobListcard(
            index: index,
            data: data,
          );
        },
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SinglePostView(data: widget.data, index: widget.index),
            ),
          );
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
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: 'Kalpurush', color: Colors.black),
              ),
            ),
            Container(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobPostDetailsPage(
                        descripton: widget.data.description!,
                        id: widget.data.jobId!,
                        jobtitle: widget.data.jobTitle!,
                        username: widget.data.createdByName!,
                        catgeoryname: widget.data.category!,
                      ),
                    ),
                  );
                },
                onTapDown: getPosition,
                onLongPress: () {
                  showMenu(
                    context: context,
                    position: relRectSize,
                    items: [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.download),
                            SizedBox(width: 10),
                            Text("Downloads"),
                          ],
                        ),
                      )
                    ],
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    widget.data.doc != null ? Image.network(jobimage + widget.data.doc!) : Image.asset('images/post.jpg'),
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

class ImagedialogBox extends StatefulWidget {
  const ImagedialogBox({Key? key}) : super(key: key);

  @override
  _ImagedialogBoxState createState() => _ImagedialogBoxState();
}

class _ImagedialogBoxState extends State<ImagedialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.white,
              child: PageView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    child: Image.asset(
                      'images/post.jpg',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String? text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text!.length > 80) {
      firstHalf = widget.text!.substring(0, 80);
      secondHalf = widget.text!.substring(80, widget.text!.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf!.isEmpty
          ? Text(
              firstHalf!,
              maxLines: 2,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                flag
                    ? Row(
                        children: [
                          Text(
                            firstHalf!,
                          ),
                          Spacer(),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  flag = !flag;
                                });
                              },
                              child: Text(
                                "    ...show more",
                                style: TextStyle(
                                    color: Color(0xFFE51D20).withOpacity(0.8)),
                              ))
                        ],
                      )
                    : Text(
                        flag ? (firstHalf!) : (firstHalf! + secondHalf!),
                      ),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          flag ? "" : "show less",
                          style: TextStyle(
                              color: Color(0xFFE51D20).withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
