import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../Provider/Jobdetails/jobdetails.dart';

class PostDetailsPage extends StatefulWidget {
  final String jobid;

  const PostDetailsPage({Key? key, required this.jobid}) : super(key: key);

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

  bool loading = false;

  @override
  void initState() {
    loading = true;
    Provider.of<JobDetailsProvider>(context, listen: false)
        .getjobdetails(widget.jobid)
        .then((value) {
      setState(() {
        loading = false;
      });
    });
    tabController = TabController(length: tablist.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final jobdetails = Provider.of<JobDetailsProvider>(context);
    var box = Hive.box('login');
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                              box.get('name'),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Lavel 1 Saller",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
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
                      jobdetails.jobDetails!.msg!.jobTitle!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      jobdetails.jobDetails!.msg!.description!,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8), height: 2),
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
