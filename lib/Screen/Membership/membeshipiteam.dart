import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Screen/Membership/membershipbuy.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';

class MembershipIteamPage extends StatefulWidget {
  const MembershipIteamPage({Key? key}) : super(key: key);

  @override
  _MembershipIteamPageState createState() => _MembershipIteamPageState();
}

class _MembershipIteamPageState extends State<MembershipIteamPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var box = Hive.box('login');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          child: const Image(
            image: AssetImage(
              'images/Top Bar illustration Solid.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          box.get('name') ?? "",
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Container(
            height: 20,
            child: Text(
              "আমার লিংক সমূহ",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Mainsearchpage(),
                    ));
              },
              icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: Column(
        children: [
          Membershipbox(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemeberShipBuyPage(),
                    ));
              },
              size: size,
              price: "ট৫০০ / মাস",
              details:
                  "লরেম ইপসামের প্যাসেজের বিভিন্ন প্রকরণ পাওয়া যায়, তবে বেশিরভাগই কিছুটা আকারে পরিবর্তিত হয়েছিল, ইনজেকশনের রসবোধ বা এলোমেলো শব্দ দিয়ে যা কিছুটা বিশ্বাসযোগ্যও নয়।",
              packagename: "ডায়মন্ড"),
          Membershipbox(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemeberShipBuyPage(),
                    ));
              },
              size: size,
              price: "ট৫০০ / মাস",
              details:
                  "লরেম ইপসামের প্যাসেজের বিভিন্ন প্রকরণ পাওয়া যায়, তবে বেশিরভাগই কিছুটা আকারে পরিবর্তিত হয়েছিল, ইনজেকশনের রসবোধ বা এলোমেলো শব্দ দিয়ে যা কিছুটা বিশ্বাসযোগ্যও নয়।",
              packagename: "ডায়মন্ড"),
          Membershipbox(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemeberShipBuyPage(),
                    ));
              },
              size: size,
              price: "ট৫০০ / মাস",
              details:
                  "লরেম ইপসামের প্যাসেজের বিভিন্ন প্রকরণ পাওয়া যায়, তবে বেশিরভাগই কিছুটা আকারে পরিবর্তিত হয়েছিল, ইনজেকশনের রসবোধ বা এলোমেলো শব্দ দিয়ে যা কিছুটা বিশ্বাসযোগ্যও নয়।",
              packagename: "ডায়মন্ড"),
        ],
      ),
    );
  }

  Widget Membershipbox(
      {Size? size, packagename, price, details, VoidCallback? onPressed}) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  packagename,
                  style: TextStyle(fontSize: 17),
                )),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                price,
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              width: size!.width * 1.0,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                details,
                textAlign: TextAlign.center,
              ),
            ),
            MaterialButton(
              color: Color(0xFFE51D20),
              onPressed: onPressed,
              child: Text(
                "নির্বাচন করুন",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
