import 'package:flutter/material.dart';
import 'package:jobs_app/login.dart';

class RegistationPage extends StatefulWidget {
  const RegistationPage({Key? key}) : super(key: key);

  @override
  _RegistationPageState createState() => _RegistationPageState();
}

class _RegistationPageState extends State<RegistationPage> {
  bool checkbox = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
        backgroundColor: const Color(0xFFE51D20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Text(
          'কানেক্ট',
          style: TextStyle(fontFamily: 'Kalpurush'),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: const Text(
            "যে কোন ধরনের কাজ /প্রজেক্ট এর কানেকশন \n এবং লিংক পেতে বা দিতে সাইন আপ করুন ",
            style: TextStyle(color: Colors.white, fontFamily: 'Kalpurush'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   alignment: Alignment.center,
            //   padding: EdgeInsets.only(bottom: 5),
            //   width: size.width,
            //   decoration: const BoxDecoration(
            //       color: Color(0xFFE51D20),
            //       borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(10),
            //           bottomRight: Radius.circular(10))),
            //   child: const Text(
            //     "যে কোন ধরনের কাজ /প্রজেক্ট এর কানেকশন \n এবং লিংক পেতে বা দিতে সাইন আপ করুন ",
            //     style: TextStyle(color: Colors.white, fontFamily: 'Kalpurush'),
            //   ),
            // ),
            formbox(name: "নাম *", hintText: "আপনার নাম"),
            SizedBox(height: 10),
            formbox(name: "ইমেইল *", hintText: "আপনার ইমেইল"),
            SizedBox(height: 10),
            formbox(name: "কোম্পানি", hintText: "আপনার বর্তমান কোম্পানি"),
            SizedBox(height: 10),
            formbox(name: "পাসওয়ার্ড *", hintText: "************"),
            SizedBox(height: 10),
            formbox(name: "কনফার্ম পাসওয়ার্ড *", hintText: "************"),
            SizedBox(height: 10),
            formbox(name: "ফোন নম্বর *", hintText: "+৮৮০১২৩৪৫৬৭৮৯"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: checkbox,
                  onChanged: (value) {
                    setState(() {
                      checkbox = value!;
                    });
                  },
                ),
                const Text.rich(TextSpan(
                    style: TextStyle(fontSize: 13, fontFamily: 'Kalpurush'),
                    children: [
                      TextSpan(
                          text: "অক্কোউন্টের জন্য সাইন আপ করে আপনি আমাদের \n"),
                      TextSpan(
                          text: "শর্তাবলী এবং নীতিমালা ",
                          style: TextStyle(color: Colors.red)),
                      TextSpan(
                        text: "এর সাথে সম্মত হলেন",
                      ),
                    ]))
                // const Text(
                //   "অক্কোউন্টের জন্য সাইন আপ করে আপনি আমাদের \n শর্তাবলী এবং নীতিমালা এর সাথে সম্মত হলেন",
                //   style: TextStyle(fontSize: 13, fontFamily: 'Kalpurush'),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: size.width * 0.4,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFFE51D20),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "একাউন্ট তৈরি করুন",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontFamily: 'Kalpurush'),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 18,
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 2,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFE51D20).withOpacity(0),
                        const Color(0xFFE51D20)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFE51D20).withOpacity(0),
                        const Color(0xFFE51D20)
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "ইতিমধ্যে একটি একাউন্ট আছে?",
                  style: TextStyle(fontSize: 13, fontFamily: 'Kalpurush'),
                )
              ],
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                redirectloginpage(context);
              },
              child: Container(
                width: size.width * 0.3,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFE51D20)),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "লগ ইন করুন",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontFamily: 'Kalpurush'),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formbox({String? name, String? hintText}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name!,
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(fontFamily: 'Kalpurush'),
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  void redirectloginpage(BuildContext context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
