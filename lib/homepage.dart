import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/Provider/Profile/profile.dart';
import 'package:jobs_app/Screen/Deshboard/deshboard2.dart';
import 'package:jobs_app/Screen/home/homepage4.dart';
import 'package:provider/provider.dart';

import 'Provider/MemberPackage/memberpackage.dart';
import 'Provider/UserPrevlies/userprevilies.dart';
import 'Screen/Chat/chatlist.dart';
import 'Screen/Deshboard/deshboard.dart';
import 'Screen/Linkscreen/linkscreen.dart';
import 'Screen/Linkscreen/mylinkscreen.dart';
import 'Screen/Notification/notification.dart';
import 'Screen/Profile/profile.dart';
import 'Screen/home/homepage3.dart';
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
  void initState() {
    Provider.of<UserPreviliesProvider>(context, listen: false)
        .getuserprevilies();
    Provider.of<ProfileProvider>(context, listen: false).getprofileinfo();
    Provider.of<PackageProvider>(context, listen: false).getpackagelist();
    super.initState();
  }

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
        children: const [
          Homepage4(),
          MylinkListPage(),
      
          ChatListpage(),
          ProfilePage(),
          NotificationPage()
        ],
      ),
    );
  }
}
