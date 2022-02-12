import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Const_value/textfielddropdown.dart';
import '../../Const_value/textfrom.dart';
import '../SSlcommerz/sslcommerz.dart';
import '../Searchpage/searchpage.dart';

class MemeberShipBuyPage extends StatefulWidget {
  const MemeberShipBuyPage({Key? key}) : super(key: key);

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
                      builder: (context) => Searchpage(),
                    ));
              },
              icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: Column(
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
            initialValue: "500",
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
                        style: TextStyle(fontSize: 14, fontFamily: 'Kalpurush'),
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
                    builder: (context) => SslcommerzPage(),
                  ));
            },
            child: Text(
              "পেমেন্ট করুন",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
