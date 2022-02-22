import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/Screen/Apply_job/custompaint.dart';
import 'package:provider/provider.dart';

import '../../Db/Model/draftdbmodel.dart';
import '../../Db/db/draftdb.dart';
import '../../Model/job_List/joblist.dart';
import '../../Provider/Jobdetails/jobdetails.dart';
import '../create_Job/audioplay.dart';
import '../create_Job/soundrecord.dart';
import '../create_Job/videorecoard2.dart';

class Applyjob2Page extends StatefulWidget {
  final String tile, connectid, username, id;
  const Applyjob2Page(
      {Key? key,
      required this.tile,
      required this.connectid,
      required this.username,
      required this.id})
      : super(key: key);

  @override
  _Applyjob2PageState createState() => _Applyjob2PageState();
}

class _Applyjob2PageState extends State<Applyjob2Page> {
  String? filename;
  String? jobid, userid, time, note, filepath, audiopath, videopath;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final recorder = Soundrecord();
  final player = AudioPlay();
  bool audiorun = false;
  Duration duration = Duration();
  Timer? timer;
  bool driftsave = false;

  SqldraftDB? sqldraftDB;

  void datasavedb() {
    Jobcreated jobcreated = Jobcreated(
        audiopath: audiopath ?? "",
        filepath: filepath ?? "",
        note: note ?? "",
        time: time ?? "",
        videopath: videopath ?? "",
        jobid: widget.id);
    sqldraftDB!.insertdata(jobcreated);
  }

  @override
  void initState() {
    sqldraftDB = SqldraftDB();
    recorder.init();
    player.playaudioinit();

    super.initState();
  }

  void addtime() {
    final addsecunt = 1;
    setState(() {
      final secount = duration.inSeconds + addsecunt;
      duration = Duration(seconds: secount);
    });
  }

  void starttimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) => addtime());
  }

  Future<bool?> showwarning(BuildContext context) async {
    if (userid != null ||
        time != null ||
        note != null ||
        filepath != null ||
        audiopath != null) {
      driftsave
          ? Navigator.pop(context)
          : AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.BOTTOMSLIDE,
              title: 'সেভ ড্রিফট',
              desc: 'আপনি কি নিশ্চিত?',
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                datasavedb();
                setState(() {
                  driftsave = true;
                });
              },
            ).show();
    } else {
      Navigator.pop(context);
    }
  }

  void cancletimer() {
    timer!.cancel();
    setState(() {
      audiorun = true;
    });
  }

  @override
  void dispose() {
    recorder.dispose();
    player.audiodispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final showpopup = await showwarning(context);
        return showpopup ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                collapsedHeight: 250,
                flexibleSpace: ClipPath(
                  clipper: Customshape(),
                  child: Container(
                    height: 270,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xFFE51D20),
                    child: Image.asset(
                      'images/post.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 5),
                          child: Text(
                            widget.tile,
                            style: const TextStyle(
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
                                "কানেক্ট আইডি: ${widget.id}",
                                style: TextStyle(
                                    fontFamily: 'Kalpurush',
                                    color: Colors.grey[700]),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => PostLinkuserprofile(
                                  //         userid: widget.data.createdBy!,
                                  //       ),
                                  //     ));
                                },
                                child: Text(
                                  widget.username,
                                  style: TextStyle(
                                      fontFamily: 'Kalpurush',
                                      color: Colors.red.withOpacity(0.7)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: Card(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "নিচের তথ্য গুলো পূরণ করুন",
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Kalpurush'),
                        )),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: Card(
                    child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: dropdowntext()),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: Card(
                    child: audiobox(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: Card(
                    child: videopicker(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: Card(
                    child: filepicker(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: Card(
                    child: textform(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          color: Colors.red,
                          onPressed: () {},
                          child: const Text(
                            "প্রস্তাবনা সম্পুন্ন করুন",
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Kalpurush'),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.red,
                          onPressed: () {
                            datasavedb();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Save Successfull")));
                          },
                          child: const Text(
                            "সেভ ড্রিফট",
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Kalpurush'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              // SliverToBoxAdapter(
              //   child: Container(
              //     margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              //     child: Card(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Container(
              //             margin: EdgeInsets.only(bottom: 5, top: 5),
              //             decoration: BoxDecoration(
              //                 color: Color(0xFFE51D20),
              //                 borderRadius: BorderRadius.circular(5)),
              //             child: Material(
              //               color: Colors.transparent,
              //               child: InkWell(
              //                 onTap: () {
              //                   // jobapply.jobapply(
              //                   //     jobid: widget.jobid,
              //                   //     note: note,
              //                   //     time: time,
              //                   //     context: context,
              //                   //     userid: box.get('userid'));
              //                 },
              //                 child: Container(
              //                   alignment: Alignment.center,
              //                   // width: MediaQuery.of(context).size.width * 0.6,
              //                   // height: MediaQuery.of(context).size.height * 0.06,
              //                   child: Text(
              //                     "প্রস্তাবনা সম্পুন্ন করুন",
              //                     style: TextStyle(
              //                         color: Colors.white,
              //                         fontFamily: 'Kalpurush'),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           // MaterialButton(
              //           //   color: Color(0xFFE51D20),

              //           //   onPressed: () {
              //           //     jobapply.jobapply(
              //           //         jobid: widget.jobid,
              //           //         note: note,
              //           //         time: time,
              //           //         context: context,
              //           //         userid: box.get('userid'));
              //           //   },
              //           //   child: Text(
              //           //     "প্রস্তাবনা সম্পুন্ন করুন",
              //           //     style:
              //           //         TextStyle(color: Colors.white, fontFamily: 'Kalpurush'),
              //           //   ),
              //           // ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdowntext() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "কাজটি করতে কেমন সময় লাগবে?",
              style: TextStyle(
                fontFamily: 'Kalpurush',
              ),
            )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownSearch<String>(
            dropdownBuilder: (context, selectedItem) {
              return Container(
                child: Text(
                  selectedItem!,
                  style: TextStyle(fontFamily: 'Kalpurush'),
                ),
              );
            },
            popupItemBuilder: (context, item, isSelected) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  item,
                  style: TextStyle(fontFamily: 'Kalpurush'),
                ),
              );
            },
            mode: Mode.MENU,
            items: [
              "অনির্ধারিত",
              "২ দিনের মত",
              "৪ দিনের মত",
              "১ সপ্তাহ",
              '২ সপ্তাহ',
              '৩ সপ্তাহ',
              '১ মাস',
              '2 মাস'
            ],
            dropdownSearchDecoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              hintStyle: TextStyle(fontFamily: 'Kalpurush'),
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            ),
            hint: "অনির্ধারিত",
            selectedItem: "অনির্ধারিত",
            onChanged: (value) {
              setState(() {
                time = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget filepicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 10, top: 4),
            child: Text(
              "ফাইল যুক্ত করুন (ঐচ্ছিক)",
              style: TextStyle(fontFamily: 'Kalpurush'),
            )),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(),
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    setState(() {
                      filename = result.files.single.name;
                      filepath = file.path;
                    });
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
                  child: Text("Choose File",
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'Kalpurush')),
                ),
              ),
              SizedBox(width: 10),
              Text(
                filename ?? "No File Chosen",
                style: TextStyle(fontFamily: 'Kalpurush'),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget textform() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            child: Text(
              "নোট (ঐচ্ছিক)",
              style: TextStyle(fontFamily: 'Kalpurush'),
            )),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                note = value;
              });
            },
            maxLines: 5,
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              hintStyle: TextStyle(fontFamily: 'Kalpurush'),
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }

  Widget audiobox() {
    String twodegit(int n) => n.toString().padLeft(2, '0');
    final minute = twodegit(duration.inMinutes.remainder(60));
    final secound = twodegit(duration.inSeconds.remainder(60));
    final isrecording = recorder.isRecoding;
    final icon = Icon(
      Icons.mic,
      color: isrecording ? Colors.red : Colors.black,
    );
    Color? color = isrecording ? Colors.red : Colors.grey[300];
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "অডিও যুক্ত করুন (ঐচ্ছিক)",
            style: TextStyle(
              fontFamily: 'Kalpurush',
            ),
          ),
          Row(
            children: [
              // MaterialButton(
              //   color: color,
              //   onPressed: () async {
              //     await recorder.tooglerecording();
              //     isrecording ? cancletimer() : starttimer();
              //     setState(() {});
              //   },
              //   child: icon,
              // ),
              InkWell(
                onTap: () async {
                  await recorder.tooglerecording();
                  isrecording ? cancletimer() : starttimer();
                  setState(() {});
                },
                child: icon,
              ),
              SizedBox(width: 10),
              Text("$minute:$secound"),
              SizedBox(width: 10),
              audiorun == true
                  ? MaterialButton(
                      color: Colors.grey[300],
                      onPressed: () async {
                        await player.toogleaudioplayer(
                          whenfinish: () {
                            setState(() {});
                          },
                        );

                        setState(() {});
                      },
                      child: Text(player.isaudioplay ? "stop" : "Play"),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget videopicker() {
    final jbdetails = Provider.of<JobDetailsProvider>(context);
    videopath = jbdetails.path;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 10, top: 4),
            child: const Text(
              "ভিডিও যুক্ত করুন (ঐচ্ছিক)",
              style: TextStyle(
                fontFamily: 'Kalpurush',
              ),
            )),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              // MaterialButton(
              //   color: Colors.grey[300],
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => VideoRecordCameraPage(),
              //         ));
              //   },
              //   child: Text("Video Record"),
              // ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoRecordCameraPage(),
                        ));
                  },
                  icon: Icon(Icons.video_file)),
              SizedBox(width: 10),
              Expanded(child: Text(jbdetails.path))
            ],
          ),
        ),
      ],
    );
  }
}
