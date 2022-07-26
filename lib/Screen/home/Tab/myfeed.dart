import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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
import '../../Linkscreen/mylinkscreen.dart';
import '../../VideoPlay/videoplayer.dart';
import 'package:path/path.dart' as path;

import '../../create_Job/audioplay.dart';

class Myfeedpage extends StatefulWidget {
  const Myfeedpage({Key? key}) : super(key: key);

  @override
  _MyfeedpageState createState() => _MyfeedpageState();
}

class _MyfeedpageState extends State<Myfeedpage> {
  bool isPlay = false;
  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomeProvider>(context);
    return Container(
      color: Colors.grey[300],
      child: homeprovider.joblist == null
          ? const Center(
              child: Text("No Job Found"),
            )
          : ListView.builder(
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
  bool isPlay = false;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  Future playaudio(String url) async {
    await audioPlayer.play(url);
  }

  RelativeRect get relRectSize =>
      RelativeRect.fromSize(tapXY! & const Size(40, 40), overlay!.size);

  // ↓ get the tap position Offset
  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final second = twoDigits(duration.inHours.remainder(60));

    return [
      if (duration.inHours < 0) hours,
      minutes,
      second,
    ].join(":");
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

  final player = AudioPlay();

  Future<void> share() async {
    await FlutterShare.share(
        title: widget.data.jobTitle!,
        text: widget.data.jobTitle!,
        linkUrl: widget.data.sharelink,
        chooserTitle: 'Example Chooser Title');
  }

  @override
  void initState() {
    // player.playaudioinit();
    categorynamefind();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime birthday = DateTime(widget.data.createdAt!.year,
        widget.data.createdAt!.month, widget.data.createdAt!.day);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
    overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox?;
    print(widget.data.doc);

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
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kalpurush'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "কানেক্ট আইডি: ${widget.data.jobId} ;",
                    style: TextStyle(
                        fontFamily: 'Kalpurush', color: Colors.grey[700]),
                  ),
                  const SizedBox(
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
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
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
                                  id: widget.data.createdBy!,
                                  tile: widget.data.jobTitle!,
                                  username: widget.data.createdByName!,
                                  image: widget.data.doc![0].isEmpty
                                      ? "no.jpg"
                                      : widget.data.doc![0],
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
