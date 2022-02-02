import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/Screen/splash/splash5.dart';

import '../../login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int pageindex = 0;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Image.asset('images/Splash.png'),
      // body: Stack(
      //   children: [
      //     PageView(
      //       onPageChanged: (value) {
      //         setState(() {
      //           pageindex = value;
      //         });
      //       },
      //       children: [
      //         // Container(
      //         //   alignment: Alignment.center,
      //         //   child: const Text(
      //         //     "কানেক্ট",
      //         //     style: TextStyle(fontSize: 120, color: Color(0xFFE51D20)),
      //         //   ),
      //         // ),
      //         // Container(
      //         //   alignment: Alignment.center,
      //         //   child: const Text(
      //         //     "কানেক্ট",
      //         //     style: TextStyle(fontSize: 120, color: Color(0xFFE51D20)),
      //         //   ),
      //         // ),
      //         // Container(
      //         //   alignment: Alignment.center,
      //         //   child: const Text(
      //         //     "কানেক্ট",
      //         //     style: TextStyle(fontSize: 120, color: Color(0xFFE51D20)),
      //         //   ),
      //         // ),
      //         // Container(
      //         //   alignment: Alignment.center,
      //         //   child: const Text(
      //         //     "কানেক্ট",
      //         //     style: TextStyle(fontSize: 120, color: Color(0xFFE51D20)),
      //         //   ),
      //         // ),
      //         Splashscreen5Page(),
      //       ],
      //     ),
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Container(
      //         height: 30,
      //         width: 150,
      //         alignment: Alignment.bottomCenter,
      //         child: ListView(
      //           scrollDirection: Axis.horizontal,
      //           children: List.generate(5, (index) {
      //             return Container(
      //               margin: EdgeInsets.all(10),
      //               height: 10,
      //               width: 10,
      //               decoration: BoxDecoration(
      //                   color: pageindex == index
      //                       ? Colors.red
      //                       : Colors.red.withOpacity(0.5),
      //                   borderRadius: BorderRadius.circular(100)),
      //             );
      //           }),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
