import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        title: const Text(
          "মোঃ হাসান ইসলাম",
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("কানেক্ট"),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Container(
            height: 20,
            child: Text(
              "প্রোফাইল",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Searchpage(),
                //     ));
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.38,
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFFFEF3F3),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFFFF5428),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: const [
                              Text(
                                "Tanvir Mahamud Shakil",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Spacer(),
                              Icon(
                                Icons.edit,
                                color: Color(0xFFE51F22),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            "@tanvirmahamud",
                            style: TextStyle(color: Color(0xFF484649)),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: Text(
                            "Web Developer",
                            style: TextStyle(color: Color(0xFFEB5456)),
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.email),
                            SizedBox(width: 5),
                            Text("shakilhassan@gmail.com")
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.phone),
                            SizedBox(width: 5),
                            Text("01932331718")
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text("ভেরিফাইড মেম্বার"),
                            SizedBox(width: 5),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Color(0xFFE94244),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 17,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("আপনার নির্বাচিত ক্যাটাগরি সমূহ"),
                      Spacer(),
                      Icon(Icons.edit, color: Color(0xFFE51F22))
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFDBDBDB),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "বড় প্রকল্প সমূহ",
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFDBDBDB),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("জমি/প্রপার্টি",
                                style: TextStyle(fontSize: 11)),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFDBDBDB),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("ব্যাংকিং ও বিনিয়োগ",
                                style: TextStyle(fontSize: 11)),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFDBDBDB),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("প্রিন্সিপাল",
                                style: TextStyle(fontSize: 11)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFDBDBDB),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "বিদেশী প্রিন্সিপাল",
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFDBDBDB),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("মেশিনারিজ",
                                style: TextStyle(fontSize: 11)),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFFDBDBDB),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("সার্ভিসেস",
                                style: TextStyle(fontSize: 11)),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: size.height * 0.2,
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFFFEF3F3),
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "মেম্বারশিপ এরিয়া",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text("বর্তমান মেম্বারশিপ : সিলভার "),
                    SizedBox(height: 5),
                    Text("মেম্বারশিপ শুরু হইয়েছে : December 22, 2021"),
                    SizedBox(height: 5),
                    Text("পরবর্তী পেমেন্ট তারিখ : February 20, 2022"),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xFFE94244),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "মেম্বারশিপ আপগ্রেড করুন",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFE94244),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "লগ আউট",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
