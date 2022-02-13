import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:jobs_app/Model/job_List/joblist.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/apply_job.dart';
import 'package:provider/provider.dart';

class Recentfeedpage extends StatefulWidget {
  const Recentfeedpage({Key? key}) : super(key: key);

  @override
  _RecentfeedpageState createState() => _RecentfeedpageState();
}

class _RecentfeedpageState extends State<Recentfeedpage> {
  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomeProvider>(context);
    return Container(
      color: Colors.grey[300],
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: homeprovider.joblist!.msg!.length,
        itemBuilder: (context, index) {
          var data = homeprovider.joblist!.msg![index];
          return JobListcard(
            data: data,
          );
        },
      ),
    );
  }
}

class JobListcard extends StatefulWidget {
  final Msg data;
  const JobListcard({Key? key, required this.data}) : super(key: key);

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
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(
              widget.data.jobTitle!,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Text("কানেক্ট আইডি: ${widget.data.jobId}"),
                SizedBox(
                  width: 10,
                ),
                Text("user: Tanvir Mahamud Shakil"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Text("Post: ${difference} day ago"),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(categoryname),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Text(
              widget.data.description!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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
                  Text(
                    '21+',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(7),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ApplyjobPage(
                              jobid: widget.data.jobId!,
                            ),
                          ));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.check,
                          size: 17,
                        ),
                        SizedBox(width: 5),
                        Text("প্রস্তাবনা দিন"),
                      ],
                    ),
                  )),
              InkWell(
                onTap: () {
                  share();
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.share,
                          size: 17,
                        ),
                        SizedBox(width: 5),
                        Text("শেয়ার"),
                      ],
                    )),
              )
            ],
          )
        ],
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
