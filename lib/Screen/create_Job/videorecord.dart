import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class Videorecordcamera extends StatefulWidget {
  const Videorecordcamera({Key? key}) : super(key: key);

  _VideorecordcameraState createState() => _VideorecordcameraState();
}

class _VideorecordcameraState extends State<Videorecordcamera>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('percobaan',
            style: TextStyle(color: Colors.black, fontSize: 20.0)),
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.camera)),
          ],
          controller: _tabController,
          indicatorColor: Colors.purple,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.purple,
        ),
        bottomOpacity: 1,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: TabBarView(controller: _tabController, children: [
          FirstWidgetItem(),
          CamRecorder(),
        ]),
      ),
    );
  }
}

class FirstWidgetItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

//////////////////////////////////////////////
///
///
///
class CamRecorder extends StatefulWidget {
  _CamRecorderState createState() => _CamRecorderState();
}

class _CamRecorderState extends State<CamRecorder> {
  CameraController? controller;
  String? videoPath;
  List<CameraDescription>? cameras;
  int? selectedCameraIdx;
  bool? _isShowGuide;
  bool? _isShowCountdownTime;
  bool? _isRecording;
  Timer? _timer;
  int _recordTime = 10;
  int _start = 5;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void startTimerCountdown() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            _isShowCountdownTime = false;
            _isRecording = true;
            startTimerRecord();
            controller != null &&
                    controller!.value.isInitialized &&
                    !controller!.value.isRecordingVideo
                ? startVideoRecording()
                : null;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void startTimerRecord() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_recordTime < 1) {
            timer.cancel();
            controller != null &&
                    controller!.value.isInitialized &&
                    controller!.value.isRecordingVideo
                ? stopVideoRecording().then((_) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         DisplayImageScreen(vidPath: videoPath!),
                    //   ),
                    // );
                    if (mounted) setState(() {});
                  })
                : null;
          } else {
            _recordTime = _recordTime - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isShowGuide = true;
    _isShowCountdownTime = false;
    _isRecording = false;
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras!.length > 0) {
        setState(() {
          selectedCameraIdx = 1;
        });

        _onCameraSwitched(cameras![selectedCameraIdx!]).then((void v) {});
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              child: _cameraPreviewWidget(),
            ),
            _isShowGuide!
                ? Opacity(
                    opacity: 0.75,
                    child: Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.only(top: 74, left: 74, right: 74),
                              height: 935.8,
                              width: 222,
                              child: Image.asset('assets/images/group.png'),
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'focus your face to the camera',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'for 10 seconds',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 15, left: 79, right: 79),
                              height: 58,
                              width: 217,
                              child: Image.asset('assets/images/group-449.png'),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 190),
                              height: 40,
                              width: 315,
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isShowGuide = false;
                                      _isShowCountdownTime = true;
                                      startTimerCountdown();
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        'Understand',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(color: Colors.black),
                    ),
                  )
                : Container(),
            _isShowCountdownTime!
                ? Container(
                    child: Center(
                      child: Text(
                        '$_start',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Container(),
            _isRecording!
                ? Positioned(
                    top: 14,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Text(
                        '$_recordTime',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Container()
          ],
        )
        // decoration: BoxDecoration(
        //   color: Colors.black,
        //   border: Border.all(
        //     color: controller != null && controller.value.isRecordingVideo
        //         ? Colors.redAccent
        //         : Colors.grey,
        //     width: 3.0,
        //   ),
        // ),

        // Padding(
        //   padding: const EdgeInsets.all(5.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: <Widget>[
        //       _cameraTogglesRowWidget(),
        //       _captureControlRowWidget(),
        //       Expanded(
        //         child: SizedBox(),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  // Display 'Loading' text when the camera is still loading.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: CameraPreview(controller!),
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    if (cameras == null) {
      return Row();
    }

    CameraDescription selectedCamera = cameras![selectedCameraIdx!];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
            onPressed: _onSwitchCamera,
            icon: Icon(_getCameraLensIcon(lensDirection)),
            label: Text(
                "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}")),
      ),
    );
  }

  /// Display the control bar with buttons to record videos.
  Widget _captureControlRowWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.videocam),
              color: Colors.blue,
              onPressed: controller != null &&
                      controller!.value.isInitialized &&
                      !controller!.value.isRecordingVideo
                  ? _onRecordButtonPressed
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              color: Colors.red,
              onPressed: controller != null &&
                      controller!.value.isInitialized &&
                      controller!.value.isRecordingVideo
                  ? onStopButtonPressed
                  : null,
            )
          ],
        ),
      ),
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _onCameraSwitched(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _onSwitchCamera() {
    selectedCameraIdx =
        selectedCameraIdx! < cameras!.length - 1 ? selectedCameraIdx! + 1 : 0;
    CameraDescription selectedCamera = cameras![selectedCameraIdx!];

    _onCameraSwitched(selectedCamera);

    setState(() {
      selectedCameraIdx = selectedCameraIdx;
    });
  }

  void _onRecordButtonPressed() {
    startVideoRecording();
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DisplayImageScreen(vidPath: videoPath!),
      //   ),
      // );
      if (mounted) setState(() {});
    });
  }

  Future<String> startVideoRecording() async {
    if (!controller!.value.isInitialized) {
      return null!;
    }

    // Do nothing if a recording is on progress
    if (controller!.value.isRecordingVideo) {
      return null!;
    }

    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$videoDirectory/${currentTime}.mp4';

    try {
      await controller!.startVideoRecording();
      videoPath = filePath;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null!;
    }

    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller!.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);
  }
}

// class DisplayImageScreen extends StatefulWidget {
//   final String? vidPath;
//   DisplayImageScreen({Key? key, @required this.vidPath}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return DisplayVideoState();
//   }
// }

// class DisplayVideoState extends State<DisplayImageScreen> {
//   VideoPlayerController videoPlayerController;
//   ChewieController chewieController;
//   Chewie playerWidget;
//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController = VideoPlayerController.file(File(widget.vidPath));
//     chewieController = ChewieController(
//         videoPlayerController: videoPlayerController,
//         aspectRatio: 2 / 4,
//         autoPlay: true,
//         looping: true);
//     playerWidget = Chewie(
//       controller: chewieController,
//     );
//   }

//   @override
//   void dispose() {
//     videoPlayerController.dispose();
//     chewieController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Chewie(
//       controller: chewieController,
//     ));
//   }
// }