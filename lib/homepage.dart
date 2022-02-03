import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Screen/Deshboard/deshboard.dart';
import 'Screen/Linkscreen/linkscreen.dart';
import 'Screen/home/homescrren.dart';
import 'bottomnavigationbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController pageController = PageController();
  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ButtomNavigationbarPage(
        pageindex: (value) {
          setState(() {
            pageindex = value;
            pageController.animateToPage(value,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeIn);
          });
        },
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [HomeScreenpage(), Linkscreenpage(), Deshboardpage()],
      ) ,
    );
  }
}
