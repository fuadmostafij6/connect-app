import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:jobs_app/Model/Userjob/userjob.dart';
import 'package:jobs_app/Provider/Userjob/userjob.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/apply_job.dart';
import 'package:jobs_app/Screen/Linkscreen/applicationlist.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage2.dart';
import 'package:jobs_app/Screen/home/Tab/recentfeed.dart';
import 'package:provider/provider.dart';

class MylinkListPage extends StatefulWidget {
  const MylinkListPage({Key? key}) : super(key: key);

  @override
  _MylinkListPageState createState() => _MylinkListPageState();
}

class _MylinkListPageState extends State<MylinkListPage> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    loading = true;
    Provider.of<Userjobpage>(context, listen: false).getuserjob().then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userjob = Provider.of<Userjobpage>(context);
    return Scaffold(
      endDrawer: DrawerPage(),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('আমার লিংক সমূহ'),

        elevation: 0,
        backgroundColor: Color(0xFFE51D20),

        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("কানেক্ট"),
          ],
        ),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(30.0),
        //   child: Container(
        //     height: 20,
        //     child: Text(
        //       "আমার লিংক সমূহ",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Searchpage2(),
                    ));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
              icon: Icon(Icons.menu)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: userjob.userjob == null || userjob.userjob!.msg!.isEmpty
          ? Center(
              child: Text("No Job"),
            )
          : ListView.builder(
              itemCount: userjob.userjob!.msg!.length,
              itemBuilder: (context, index) {
                var data = userjob.userjob!.msg![index];
                return JobListcard(data: data);
              },
            ),
    );
  }
}

class JobListcard extends StatefulWidget {
  final Msg data;
  const JobListcard({Key? key, required this.data}) : super(key: key);

  @override
  _JobListcardState createState() => _JobListcardState();
}

class _JobListcardState extends State<JobListcard> {
  // String categoryname = '';

  // void categorynamefind() {
  //   final homeprovider = Provider.of<HomeProvider>(context, listen: false);
  //   for (var i = 0; i < homeprovider.categorylist!.msg!.length; i++) {
  //     if (widget.data.category == homeprovider.categorylist!.msg![i].catId) {
  //       setState(() {
  //         categoryname = homeprovider.categorylist!.msg![i].catName!;
  //       });
  //     }
  //   }
  // }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  void initState() {
    // categorynamefind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime birthday = DateTime(widget.data.createdAt!.year,
        widget.data.createdAt!.month, widget.data.createdAt!.day);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;

    return Container(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('images/mainicon.png'),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.jobTitle!,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              "কানেক্ট আইডি: ${widget.data.jobId}",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontFamily: 'Kalpurush'),
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.data.createdByName!,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        Text(
                          "Post: ${difference} day ago",
                          style: TextStyle(
                              color: Colors.grey[700], fontFamily: 'Kalpurush'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                widget.data.description!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: 'Kalpurush'),
              ),
            ),
            Divider(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ApplyjobPage(
                                jobid: widget.data.jobId!,
                              ),
                            ));
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check,
                            size: 17,
                          ),
                          SizedBox(width: 5),
                          Text("প্রস্তাবনা দিন",
                              style: TextStyle(fontFamily: 'Kalpurush')),
                        ],
                      ),
                    )),
                InkWell(
                  onTap: () {
                    share();
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            size: 17,
                          ),
                          SizedBox(width: 5),
                          Text("শেয়ার",
                              style: TextStyle(fontFamily: 'Kalpurush')),
                        ],
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
