// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Provider/Jobdetails/jobdetails.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:jobs_app/Screen/create_Job/audioplay.dart';
import 'package:jobs_app/Screen/create_Job/soundrecord.dart';
import 'package:jobs_app/Screen/create_Job/videorecoard2.dart';
import 'package:jobs_app/Screen/create_Job/videorecord.dart';
import 'package:provider/provider.dart';
import 'package:simple_timer/simple_timer.dart';

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

  Duration duration = Duration();
  Timer? timer;

  @override
  void initState() {
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
      appBar: AppBar(
        title: Text('লিংকঅ্যাপ'),
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
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Searchpage(),
                    ));
              },
              icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "আপনি যে কাজ/প্রজেক্ট-এর কানেকশন এবং লিংক দিতে চান তা এখানে লিপিবদ্ধ করুন",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            dropdowntext(),
            SizedBox(height: 10),
            Textbox(),
            SizedBox(height: 10),
            textform(),
            audiobox(),
            SizedBox(height: 10),
            filepicker(),
            SizedBox(height: 10),
            phoneTextbox(),
            MaterialButton(
              color: Color(0xFFE51D20),
              onPressed: () {
                jbdetails.newjobcreate(
                    category: category,
                    contactnumber: contactnumber ?? "",
                    description: description ?? "",
                    jobtite: jobtite ?? "",
                    context: context,
                    userid: box.get('userid'));
              },
              child: Text(
                "সাবমিট করুন",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Textbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 10), child: Text("(০২) শিরোনাম")),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.all(10), child: Text("(০১) কাজের ক্যাটাগরি")),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownSearch<String>(
            mode: Mode.MENU,
            items:
                homeprovider.categorylist!.msg!.map((e) => e.catName!).toList(),
            dropdownSearchDecoration: InputDecoration(
                isDense: true,
                hintText: "ক্যাটাগরি",
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            onChanged: (value) {
              for (var i = 0; i < homeprovider.categorylist!.msg!.length; i++) {
                if (homeprovider.categorylist!.msg![i].catName == value) {
                  setState(() {
                    category = homeprovider.categorylist!.msg![i].catId;
                  });
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget filepicker() {
    final jbdetails = Provider.of<JobDetailsProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 10, top: 4),
            child: Text("(০৫) ভিডিও  যুক্ত করুন (ঐচ্ছিক)")),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              MaterialButton(
                color: Colors.grey[300],
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoRecordCameraPage(),
                      ));
                },
                child: Text("Video Record"),
              ),
              SizedBox(width: 10),
              Expanded(child: Text(jbdetails.path))
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
            child: Text("(০৩) কাজের বর্ননা")),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
            maxLines: 5,
            decoration: InputDecoration(),
          ),
        ),
      ],
    );
  }

  Widget phoneTextbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("(০৬) কন্টাক নম্বর")),
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
              hintText: "০১৯৩২৩৩১৭১৮",
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
          ),
        )
      ],
    );
  }

  Widget audiobox() {
    String twodegit(int n) => n.toString().padLeft(2, '0');
    final minute = twodegit(duration.inMinutes.remainder(60));
    final secound = twodegit(duration.inSeconds.remainder(60));
    final isrecording = recorder.isRecoding;
    final icon = isrecording
        ? const Icon(
            Icons.stop,
            color: Colors.white,
          )
        : Icon(Icons.mic);
    Color? color = isrecording ? Colors.red : Colors.grey[300];
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("(০৪) অডিও  যুক্ত করুন (ঐচ্ছিক)"),
          Row(
            children: [
              MaterialButton(
                color: color,
                onPressed: () async {
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
}
