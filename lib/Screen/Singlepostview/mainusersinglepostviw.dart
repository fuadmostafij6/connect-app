import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Screen/ApplicationList/applicationlist.dart';
import 'package:provider/provider.dart';


import '../../Const_value/apilink.dart';
import '../../Model/Userjob/userjob.dart';
import '../../Provider/Pdf/pdf.dart';
import '../../Provider/Userjob/userjob.dart';
import '../../Provider/home.dart';
import '../JobpostDetails/jobpostdetails.dart';
import '../Linkscreen/mylinkscreen.dart';
import '../Profile/postlinkuser.dart';
import '../VideoPlay/videoplayer.dart';
import '../create_Job/audioplay.dart';

import 'package:path/path.dart' as path;

import '../create_Job/jobedit.dart';
import '../jobpdf.dart';
class MainuserSinglePostView extends StatefulWidget {
  final Msgs data;
  final int index;
  const MainuserSinglePostView(
      {Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<MainuserSinglePostView> createState() => _MainuserSinglePostViewState();
}

class _MainuserSinglePostViewState extends State<MainuserSinglePostView> {
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
          child: JobListcard(data: widget.data, index: widget.index)),
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
  bool isPlay = false;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  void refreshdara() {
    var box = Hive.box('login');
    Provider.of<Userjobpage>(context, listen: false)
        .getuserjob(userid: box.get('userid'));
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

  final player = AudioPlay();
  @override
  void initState() {
   // player.playaudioinit();

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlay = event == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    categorynamefind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userjob = Provider.of<Userjobpage>(context);
    DateTime birthday = DateTime(widget.data.createdAt!.year,
        widget.data.createdAt!.month, widget.data.createdAt!.day);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10, top: widget.index == 0 ? 10 : 0),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => MainuserSinglePostView(
          //         data: widget.data, index: widget.index),
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
                    width: 5,
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Post: $difference day ago by",
                    style: TextStyle(
                        fontFamily: 'Kalpurush', color: Colors.grey[700]),
                  ),
                  const SizedBox(
                    width: 5,
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
                  // widget.data.doc != null
                  //     ? Image.network(jobimage + widget.data.doc!)
                  //     : Image.asset('images/post.jpg'),
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
                          child: Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Image.network(
                              jobimage + data,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else if (path.extension(data) == ".mp4") {
                        return Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: ChewieDemo(
                            videourl: jobimage + data,
                          ),
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
                            child: Container(
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                child: PdfView(data: data)));
                      } else if (path.extension(data) == ".aac") {
                        print(jobimage + data);
                        return Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),

                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(onPressed: ()async{
                                if(isPlay){
                                  await audioPlayer.pause();
                                }
                                else{
                                  String url = jobimage + data;
                                  await audioPlayer.play(url);

                                }

                              }, icon: isPlay==false?const Icon(Icons.play_arrow, color: Colors.white,):const Icon(Icons.pause,color: Colors.white)),
                              Text("${duration.inMinutes.remainder(60)-position.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60)-position.inSeconds.remainder(60)}", style: TextStyle(color: Colors.white),),
                              Slider(value: position.inSeconds.toDouble(),
                                min:0,
                                max: duration.inSeconds.toDouble(),

                                onChanged: (val)async{
                                  final position = Duration(seconds: val.toInt());
                                  await audioPlayer.seek(position);
                                  await audioPlayer.resume();

                                }, activeColor: Colors.white,
                                inactiveColor: Colors.black,
                              )
                            ],
                          ),
                        );
                      } else {
                        return Image.asset(
                          'images/post.jpg',
                          fit: BoxFit.cover,
                        );
                      }
                    }),
                  )
                ],
              ),
            ),
            const Divider(
              height: 0,
            ),
            Row(
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
                              builder: (context) => ApplicationList( details: widget.data.description, id:widget.data.createdBy!, title: widget.data.jobTitle!, jobid: widget.data.jobId,),
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
                        padding: const EdgeInsets.all(9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'images/svg/share-solid.svg',
                                  height: 15,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(width: 5),
                                Text("শেয়ার",
                                    style: TextStyle(
                                        fontFamily: 'Kalpurush',
                                        color: Colors.grey[700])),
                              ],
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
                      onTap: () {},
                      child: SizedBox(
                        height: 35,
                        child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          onSelected: (value) {
                            if (value == 0) {
                              userjob
                                  .removejob(jobid: widget.data.jobId)
                                  .then((value) => refreshdara());
                            } else if (value == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobeditPage(
                                        data: widget.data,
                                        index: widget.index),
                                  ));
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  value: 0,
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
                                  value: 1,
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
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PdfView extends StatefulWidget {
  final String data;
  const PdfView({Key? key, required this.data}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  File? pdffile;

  Future loadpdf() async {
    var file = await Provider.of<PdfProvider>(context, listen: false)
        .loadNetwork(jobimage + widget.data);
    setState(() {
      pdffile = file;
    });
  }

  @override
  void initState() {
    loadpdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => JobPdfView(path: pdffile!.path))));
        },
        child: JobPdfView(path: pdffile!.path));
  }
}