import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/Model/job_List/joblist.dart';
import 'package:jobs_app/Provider/Jobdetails/jobdetails.dart';
import 'package:jobs_app/main.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class VideoRecordCameraPage extends StatefulWidget {
  const VideoRecordCameraPage({Key? key}) : super(key: key);

  @override
  _VideoRecordCameraPageState createState() => _VideoRecordCameraPageState();
}

class _VideoRecordCameraPageState extends State<VideoRecordCameraPage> {
  CameraController? cameraController;
  Duration duration = Duration();
  Timer? timer;

  bool fontcamera = false;

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
  }

  Future<void>? initializedcontroller;

  bool isdiable = false;
  bool completevideo = false;
  String? path;

  @override
  void initState() {
    cameraController = CameraController(cameras![0], ResolutionPreset.high);
    initializedcontroller = cameraController!.initialize();
    super.initState();
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twodegit(int n) => n.toString().padLeft(2, '0');
    final minute = twodegit(duration.inMinutes.remainder(60));
    final secound = twodegit(duration.inSeconds.remainder(60));
    final jbdetails = Provider.of<JobDetailsProvider>(context);
    return FutureBuilder(
      future: initializedcontroller,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CameraPreview(cameraController!),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.stop,
                                color: Colors.red,
                              ),
                              Text(
                                "$minute:$secound",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          )),
                      completevideo == true
                          ? Container(
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.check,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(
                              child: isdiable
                                  ? MaterialButton(
                                      onPressed: () async {
                                        setState(() {
                                          cameraController!
                                              .stopVideoRecording();
                                          cancletimer();
                                          jbdetails.getpath(path!);
                                          isdiable = false;
                                          completevideo = true;
                                          print(path);
                                        });
                                      },
                                      child: Icon(
                                        Icons.stop,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    )
                                  : MaterialButton(
                                      onPressed: () async {
                                        try {
                                          await initializedcontroller;
                                          path = join(
                                              (await getApplicationDocumentsDirectory())
                                                  .path,
                                              '${DateTime.now()}.mp4');
                                          setState(() {
                                            cameraController!
                                                .startVideoRecording();
                                            starttimer();

                                            isdiable = true;
                                          });
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Icon(
                                        Icons.camera,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                      onPressed: () {
                        if (fontcamera == false) {
                          cameraController = CameraController(
                              cameras![1], ResolutionPreset.high);
                          initializedcontroller =
                              cameraController!.initialize();
                          setState(() {
                            fontcamera = true;
                          });
                        } else {
                          cameraController = CameraController(
                              cameras![0], ResolutionPreset.high);
                          initializedcontroller =
                              cameraController!.initialize();
                          setState(() {
                            fontcamera = false;
                          });
                        }
                      },
                      child: Icon(
                        Icons.camera_front,
                        size: 50,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          );
        } else {
          return Center();
        }
      },
    );
  }
}
