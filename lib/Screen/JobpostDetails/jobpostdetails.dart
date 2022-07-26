import 'package:flutter/material.dart';
import 'package:jobs_app/Const_value/apilink.dart';
import 'package:path/path.dart' as path;

import '../Linkscreen/mylinkscreen.dart';
import '../VideoPlay/videoplayer.dart';

class JobPostDetailsPage extends StatefulWidget {
  final String jobtitle, id, username, descripton, catgeoryname, doc;
  const JobPostDetailsPage(
      {Key? key,
      required this.jobtitle,
      required this.id,
      required this.username,
      required this.descripton,
      required this.catgeoryname,
      required this.doc})
      : super(key: key);

  @override
  _JobPostDetailsPageState createState() => _JobPostDetailsPageState();
}

class _JobPostDetailsPageState extends State<JobPostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset(
          //   'images/post.jpg',
          //   fit: BoxFit.cover,
          // ),
          if (path.extension(widget.doc) == ".jpg" ||
              path.extension(widget.doc) == ".png" ||
              path.extension(widget.doc) == ".JPG")
            Image.network(
              jobimage + widget.doc,
              fit: BoxFit.cover,
            ),
          if (path.extension(widget.doc) == ".mp4")
            ChewieDemo(
              videourl: jobimage + widget.doc,
            ),
          if (path.extension(widget.doc) == ".pdf") PdfView(data: widget.doc),

          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15, top: 5),
                        child: Text(
                          widget.jobtitle,
                          style: TextStyle(
                              color: Colors.white,
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
                              "কানেক্ট আইডি: ${widget.id}",
                              style: TextStyle(
                                  fontFamily: 'Kalpurush', color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {

                              },
                              child: Text(
                                widget.username,
                                style: TextStyle(
                                    fontFamily: 'Kalpurush',
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                widget.catgeoryname,
                                style: TextStyle(
                                    fontFamily: 'Kalpurush',
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          widget.descripton,
                          style: TextStyle(
                              fontFamily: 'Kalpurush', color: Colors.white),
                        ),
                      ),
                    ],
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
