// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Provider/Jobdetails/jobdetails.dart';
import 'package:jobs_app/Provider/Upload/upload.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:jobs_app/Screen/create_Job/audioplay.dart';
import 'package:jobs_app/Screen/create_Job/soundrecord.dart';
import 'package:jobs_app/Screen/create_Job/videorecoard2.dart';
import 'package:jobs_app/Screen/create_Job/videorecord.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:path/path.dart' as join1;

import '../../Provider/Job_Apply/job_apply.dart';
import '../../Provider/Userjob/userjob.dart';

class CreateJobpage extends StatefulWidget {
  const CreateJobpage({Key? key}) : super(key: key);

  @override
  _CreateJobpageState createState() => _CreateJobpageState();
}

class _CreateJobpageState extends State<CreateJobpage> {
  String? filename;

  String? jobtite, description, category, userid, contactnumber;

  final recorder = Soundrecord();
  final player = AudioPlay();

  bool audiorun = false;
  bool videoupload = false;
  bool imageupload = false;
  bool loading = false;

  String? audioname;

  Duration duration = Duration();
  Timer? timer;

  String image = '';
  String audio = '';
  String video = '';

  @override
  void initState() {
    var rng = Random();
    audioname = rng.nextInt(1000 * 100000).toString();
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
    final jbdetails = Provider.of<JobDetailsProvider>(context);
    var box = Hive.box('login');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'লিংকঅ্যাপ',
          style: TextStyle(fontFamily: 'Kalpurush'),
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
        // leading: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text("কানেক্ট"),
        //   ],
        // ),

        actions: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => Mainsearchpage(),
          //           ));
          //     },
          //     icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    "আপনি যে কাজ/প্রজেক্ট-এর কানেকশন এবং লিংক দিতে চান তা এখানে লিপিবদ্ধ করুন",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kalpurush'),
                  ),
                ),
              ),
              Card(
                  child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: dropdowntext())),
              // SizedBox(height: 10),
              Card(
                  child: Container(
                      padding: EdgeInsets.only(top: 10), child: Textbox())),
              // SizedBox(height: 10),
              Card(
                  child: Container(
                      padding: EdgeInsets.only(top: 10), child: textform())),
              // Card(child: audiobox()),
              // Card(child: videopicker()),
              // // SizedBox(height: 10),
              // Card(child: filepicker()),
              // SizedBox(height: 10),
              uploadbox(),
              Card(
                  child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: phoneTextbox())),

              MaterialButton(
                color: Color(0xFFE51D20),
                onPressed: () {
                  jbdetails
                      .newjobcreate(
                          category: category,
                          contactnumber: contactnumber ?? "",
                          description: description ?? "",
                          jobtite: jobtite ?? "",
                          context: context,
                          image: image,
                          audio: audio,
                          video: video,
                          userid: box.get('userid'))
                      .then((value) =>
                          Provider.of<Userjobpage>(context, listen: false)
                              .getuserjob(userid: box.get('userid')));

                  // List<String> d = [];
                  // uploadlist.forEach((element) {
                  //   d.add("${"$element"}");
                  // });
                  // print(d);
                },
                child: Text(
                  "সাবমিট করুন",
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Kalpurush'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Textbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //     margin: EdgeInsets.only(left: 10),
        //     child: Text(
        //       "শিরোনাম",
        //       style: TextStyle(fontFamily: 'Kalpurush'),
        //     )),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                jobtite = value;
              });
            },
            decoration: InputDecoration(
              isDense: true,
              hintText: "শিরোনাম",
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
          ),
        )
      ],
    );
  }

  Widget dropdowntext() {
    final homeprovider = Provider.of<HomeProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //     padding: EdgeInsets.all(10),
          //     child: Text(
          //       "কাজের ক্যাটাগরি",
          //       style: TextStyle(fontFamily: 'Kalpurush'),
          //     )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              hint: "কাজের ক্যাটাগরি",
              items: homeprovider.allcategory!.msg!
                  .map((e) => e.catName!)
                  .toList(),
              dropdownSearchDecoration: InputDecoration(
                  isDense: true,
                  hintText: "কাজের ক্যাটাগরি",
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
              onChanged: (value) {
                for (var i = 0;
                    i < homeprovider.allcategory!.msg!.length;
                    i++) {
                  if (homeprovider.allcategory!.msg![i].catName == value) {
                    setState(() {
                      category = homeprovider.allcategory!.msg![i].catId;
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget filepicker() {
  //   final upload = Provider.of<UploadProvider>(context);
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //           margin: EdgeInsets.only(left: 10, top: 4),
  //           child: Text(
  //             "ফাইল যুক্ত করুন (ঐচ্ছিক)",
  //             style: TextStyle(fontFamily: 'Kalpurush'),
  //           )),
  //       Container(
  //         margin: EdgeInsets.all(10),
  //         padding: EdgeInsets.all(5),
  //         decoration: BoxDecoration(),
  //         child: Row(
  //           children: [
  //             InkWell(
  //               onTap: () async {
  //                 FilePickerResult? result =
  //                     await FilePicker.platform.pickFiles();

  //                 if (result != null) {
  //                   File file = File(result.files.single.path!);
  //                   setState(() {
  //                     filename = result.files.single.name;
  //                   });
  //                   upload.uploaddile(file.path);
  //                 } else {
  //                   // User canceled the picker
  //                 }
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //                 decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
  //                 child: Text("Choose File",
  //                     style: TextStyle(
  //                         color: Colors.black, fontFamily: 'Kalpurush')),
  //               ),
  //             ),
  //             SizedBox(width: 10),
  //             Expanded(
  //               child: Text(
  //                 filename ?? "No File Chosen",
  //                 overflow: TextOverflow.ellipsis,
  //                 maxLines: 1,
  //                 style: TextStyle(fontFamily: 'Kalpurush'),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget textform() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        //     child: Text(
        //       "কাজের বর্ননা",
        //       style: TextStyle(fontFamily: 'Kalpurush'),
        //     )),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
            maxLines: 5,
            decoration: InputDecoration(hintText: "কাজের বর্ননা"),
          ),
        ),
      ],
    );
  }

  Widget phoneTextbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //     margin: EdgeInsets.only(left: 10),
        //     child: Text(
        //       "কন্টাক নম্বর",
        //       style: TextStyle(fontFamily: 'Kalpurush'),
        //     )),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                contactnumber = value;
              });
            },
            decoration: const InputDecoration(
              isDense: true,
              hintText: "কন্টাক নম্বর",
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
          ),
        )
      ],
    );
  }

  // Widget audiobox() {
  //   final upload = Provider.of<UploadProvider>(context);

  //   String twodegit(int n) => n.toString().padLeft(2, '0');
  //   final minute = twodegit(duration.inMinutes.remainder(60));
  //   final secound = twodegit(duration.inSeconds.remainder(60));
  //   final isrecording = recorder.isRecoding;
  //   final icon = Icon(
  //     Icons.mic,
  //     color: isrecording ? Colors.red : Colors.black,
  //   );
  //   Color? color = isrecording ? Colors.red : Colors.grey[300];
  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "অডিও যুক্ত করুন (ঐচ্ছিক)",
  //           style: TextStyle(
  //             fontFamily: 'Kalpurush',
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             // MaterialButton(
  //             //   color: color,
  //             //   onPressed: () async {
  //             //     await recorder.tooglerecording();
  //             //     isrecording ? cancletimer() : starttimer();
  //             //     setState(() {});
  //             //   },
  //             //   child: icon,
  //             // ),
  //             InkWell(
  //               onTap: () async {
  //                 await recorder.tooglerecording();
  //                 isrecording ? cancletimer() : starttimer();
  //                 setState(() {});
  //               },
  //               child: icon,
  //             ),
  //             SizedBox(width: 10),
  //             Text("$minute:$secound"),
  //             SizedBox(width: 10),
  //             audiorun == true
  //                 ? MaterialButton(
  //                     color: Colors.grey[300],
  //                     onPressed: () async {
  //                       await player.toogleaudioplayer(
  //                         whenfinish: () {
  //                           setState(() {});
  //                         },
  //                       );

  //                       setState(() {});
  //                     },
  //                     child: Text(player.isaudioplay ? "stop" : "Play"),
  //                   )
  //                 : Container(),
  //           ],
  //         ),
  //         MaterialButton(
  //           color: Colors.grey[200],
  //           onPressed: () async {
  //             String path = join.join(
  //                 (await getTemporaryDirectory()).path, 'audio_example.aac');
  //             upload.uploaddile(path);
  //           },
  //           child: Text("upload"),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget videopicker() {
  //   final upload = Provider.of<UploadProvider>(context);
  //   final jbdetails = Provider.of<JobDetailsProvider>(context);

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //           margin: const EdgeInsets.only(left: 10, top: 4),
  //           child: const Text(
  //             "ভিডিও যুক্ত করুন (ঐচ্ছিক)",
  //             style: TextStyle(
  //               fontFamily: 'Kalpurush',
  //             ),
  //           )),
  //       Container(
  //         margin: const EdgeInsets.all(10),
  //         padding: const EdgeInsets.all(5),
  //         child: Row(
  //           children: [
  //             // MaterialButton(
  //             //   color: Colors.grey[300],
  //             //   onPressed: () {
  //             //     Navigator.push(
  //             //         context,
  //             //         MaterialPageRoute(
  //             //           builder: (context) => VideoRecordCameraPage(),
  //             //         ));
  //             //   },
  //             //   child: Text("Video Record"),
  //             // ),
  //             IconButton(
  //                 onPressed: () {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => VideoRecordCameraPage(),
  //                       ));
  //                 },
  //                 icon: Icon(Icons.video_file)),
  //             SizedBox(width: 10),
  //             Expanded(child: Text(jbdetails.path)),
  //             loading
  //                 ? CircularProgressIndicator()
  //                 : MaterialButton(
  //                     onPressed: () {
  //                       setState(() {
  //                         loading = true;
  //                       });
  //                       upload.uploaddile(jbdetails.path).then((value) {
  //                         setState(() {
  //                           loading = false;
  //                         });
  //                       });
  //                     },
  //                     child: Text("Upload"),
  //                   )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget uploadbox() {
    final upload = Provider.of<UploadProvider>(context);
    final jbdetails = Provider.of<JobDetailsProvider>(context);
    String twodegit(int n) => n.toString().padLeft(2, '0');
    final minute = twodegit(duration.inMinutes.remainder(60));
    final secound = twodegit(duration.inSeconds.remainder(60));
    final isrecording = recorder.isRecoding;
    final icon = Icon(
      Icons.mic,
      color: isrecording ? Colors.red : Colors.black,
    );
    Color? color = isrecording ? Colors.red : Colors.grey[300];
    return Card(
      child: Column(
        children: [
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () async {
                        await recorder.tooglerecording("${audioname!}.aac");
                        isrecording ? cancletimer() : starttimer();
                        setState(() {
                          videoupload = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: icon,
                          ),
                          Text("$minute:$secound"),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          audiorun = false;
                          videoupload = true;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoRecordCameraPage(),
                            ));
                      },
                      child: Container(
                        child: Icon(Icons.video_file),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          File file = File(result.files.single.path!);

                          setState(() {
                            filename = result.files.single.name;
                            image = join1.basename(file.path);
                          });
                          upload.uploaddile(file.path);
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: Container(
                        child: Icon(Icons.image),
                      ),
                    )),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                audiorun == true
                    ? MaterialButton(
                        color: Colors.red,
                        onPressed: () async {
                          String path = join1.join(
                              (await getTemporaryDirectory()).path,
                              "${audioname}.aac");
                          print(path);
                          await player.toogleaudioplayer(
                              whenfinish: () {
                                setState(() {});
                              },
                              path: path);

                          setState(() {});
                        },
                        child: Text(
                          player.isaudioplay ? "stop" : "Play",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Container(),
                if (audiorun == true) Spacer(),
                audiorun == true
                    ? MaterialButton(
                        color: Colors.red,
                        onPressed: () async {
                          String path = join1.join(
                              (await getTemporaryDirectory()).path,
                              "${audioname}.aac");
                          print(path);
                          audio = join1.basename(path);
                          upload.uploaddile(path).then((value) {
                            setState(() {
                              audiorun = false;
                            });
                          });
                        },
                        child: Text("upload",
                            style: TextStyle(color: Colors.white)),
                      )
                    : Container(),
                videoupload
                    ? Expanded(
                        child: Text(
                          jbdetails.path,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    : Container(),
                videoupload
                    ? loading
                        ? CircularProgressIndicator()
                        : MaterialButton(
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                loading = true;
                              });
                              video = join1.basename(jbdetails.path);
                              upload.uploaddile(jbdetails.path).then((value) {
                                setState(() {
                                  loading = false;
                                });
                              });
                            },
                            child: Text(
                              "Upload",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
