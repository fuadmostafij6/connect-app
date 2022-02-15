import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:jobs_app/Model/job_List/joblist.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/apply_job.dart';
import 'package:provider/provider.dart';

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
  // String categoryname = '';

  // void categorynamefind() {
  //   final homeprovider = Provider.of<HomeProvider>(context, listen: false);
  //   for (var i = 0; i < homeprovider.categorylist!.msg!.length; i++) {
  //     if (widget.data.category == homeprovider.categorylist!.msg![i].catId) {
  //       setState(() {
  //         categoryname = homeprovider.categorylist!.msg![i].catName!;
  //       });
  //     }
  //   }
  // }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  void initState() {
    // categorynamefind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime birthday = DateTime(widget.data.createdAt!.year,
        widget.data.createdAt!.month, widget.data.createdAt!.day);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;

    return Container(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('images/mainicon.png'),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.jobTitle!,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              "কানেক্ট আইডি: ${widget.data.jobId}",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontFamily: 'Kalpurush'),
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.data.createdByName!,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        Text(
                          "Post: ${difference} day ago",
                          style: TextStyle(
                              color: Colors.grey[700], fontFamily: 'Kalpurush'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                widget.data.description!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: 'Kalpurush'),
              ),
            ),
            Divider(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
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
                          Text("প্রস্তাবনা দিন",
                              style: TextStyle(fontFamily: 'Kalpurush')),
                        ],
                      ),
                    )),
                InkWell(
                  onTap: () {
                    share();
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            size: 17,
                          ),
                          SizedBox(width: 5),
                          Text("শেয়ার",
                              style: TextStyle(fontFamily: 'Kalpurush')),
                        ],
                      )),
                )
              ],
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
