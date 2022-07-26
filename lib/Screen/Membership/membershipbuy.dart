import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';

import '../../Const_value/textfielddropdown.dart';
import '../../Const_value/textfrom.dart';
import '../Amarpay/amarpay.dart';
import '../SSlcommerz/sslcommerz.dart';
import '../Searchpage/searchpage.dart';

class MemeberShipBuyPage extends StatefulWidget {
  final String price;
  const MemeberShipBuyPage({Key? key, required this.price}) : super(key: key);

  @override
  _MemeberShipBuyPageState createState() => _MemeberShipBuyPageState();
}

class _MemeberShipBuyPageState extends State<MemeberShipBuyPage> {
  bool checkbox = false;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('login');
    return Scaffold(
      appBar: AppBar(
        title: Text("MemberShip Buy"),
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextfromPage(
              name: "আপনার নাম",
              hinttext: "আপনার নাম",
              onSaved: (value) {},
            ),
            TextfromPage(
              name: "ঠিকানা",
              hinttext: "ঠিকানা",
              onSaved: (value) {},
            ),
            TextfieldDropdown(
              name: "দেশ",
              hinttext: "দেশ",
              items: ['Bangladesh'],
              onSaved: (value) {},
            ),
            TextfieldDropdown(
              name: "শহর",
              hinttext: "শহর",
              items: ["Dhaka", 'Gazipur', 'Narayanganj'],
              onSaved: (value) {},
            ),
            TextfromPage(
              name: "পোষ্ট কোড",
              hinttext: "পোষ্ট কোড",
              onSaved: (value) {},
            ),
            TextfromPage(
              name: "মেম্বারশিপ মুল্য",
              hinttext: "মেম্বারশিপ মুল্য",
              initialValue: widget.price,
              enabled: false,
              onSaved: (value) {},
            ),
            Row(
              children: [
                Checkbox(
                  value: checkbox,
                  onChanged: (value) {
                    setState(() {
                      checkbox = value!;
                    });
                  },
                ),
                Flexible(
                  child: RichText(
                      maxLines: 2,
                      text: const TextSpan(
                          style:
                              TextStyle(fontSize: 14, fontFamily: 'Kalpurush'),
                          children: [
                            TextSpan(
                                style: TextStyle(color: Colors.black),
                                text: "পেমেন্ট এমাউন্ট অফেরত যোগ্য। আমাদের "),
                            TextSpan(
                                text: "শর্তাবলী এবং নীতিমালা সমূহ ",
                                style: TextStyle(color: Colors.red)),
                          ])),
                ),
              ],
            ),
            MaterialButton(
              color: Color(0xFFE51D20),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AmarpayPage(),
                    ));
              },
              child: Text(
                "পেমেন্ট করুন",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
