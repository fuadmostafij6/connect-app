import 'package:flutter/material.dart';

class PostDetailsPage extends StatefulWidget {
  const PostDetailsPage({Key? key}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage>
    with TickerProviderStateMixin {
  TabController? tabController;

  List<Tab> tablist = [
    Tab(text: "Video"),
    Tab(text: "Audio"),
  ];

  @override
  void initState() {
    tabController = TabController(length: tablist.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.green,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'images/download.jpg',
                    fit: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.favorite, color: Colors.white),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              color: Colors.grey[200],
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('images/Splash.png'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Sagordpi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Lavel 1 Saller",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.arrow_downward_sharp),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "A job title can describe the responsibilities of the position, the level of the job, or both",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "The Balance Careers and our third-party partners use cookies and process personal data like unique identifiers based on your consent to store and/or access information on a device, A job title is a term that describes in a few words or less the position held by an employee. Depending on the job, a job title can describe the level of the position or the responsibilities of the person holding the position.",
                style:
                    TextStyle(color: Colors.black.withOpacity(0.8), height: 2),
              ),
            ),

            Container(
              height: 250,
              margin: EdgeInsets.only(bottom: 20),
              width: double.infinity,
              child: Card(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'images/Splash.png',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.play_arrow,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.volume_down,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // TabBar(tabs: tablist, controller: tabController)
          ],
        ),
      ),
    );
  }
}
