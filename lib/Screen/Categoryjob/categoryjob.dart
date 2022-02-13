import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:jobs_app/Model/job_List/joblist.dart';
import 'package:jobs_app/Provider/Categorybyjob/categoryjob.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Linkscreen/applicationlist.dart';
import 'package:jobs_app/Screen/home/Tab/recentfeed.dart';
import 'package:provider/provider.dart';

class CategoryjobPage extends StatefulWidget {
  final String categoryid, categoryname;
  const CategoryjobPage(
      {Key? key, required this.categoryid, required this.categoryname})
      : super(key: key);

  @override
  _CategoryjobPageState createState() => _CategoryjobPageState();
}

class _CategoryjobPageState extends State<CategoryjobPage> {
  bool loading = false;

  @override
  void initState() {
    loading = true;
    Provider.of<CategoryJobprovider>(context, listen: false)
        .getcategoryjob(widget.categoryid)
        .then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryjob = Provider.of<CategoryJobprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryname),
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Searchpage(),
                //     ));
              },
              icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : categoryjob.joblist!.msg!.isEmpty
              ? Center(
                  child: Text('No Job Found'),
                )
              : Container(
                  child: ListView.builder(
                    itemCount: categoryjob.joblist!.msg!.length,
                    itemBuilder: (context, index) {
                      var data = categoryjob.joblist!.msg![index];
                      return JobListcard(data: data);
                    },
                  ),
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
  String categoryname = '';

  void categorynamefind() {
    final homeprovider = Provider.of<HomeProvider>(context, listen: false);
    for (var i = 0; i < homeprovider.categorylist!.msg!.length; i++) {
      if (widget.data.category == homeprovider.categorylist!.msg![i].catId) {
        setState(() {
          categoryname = homeprovider.categorylist!.msg![i].catName!;
        });
      }
    }
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  void initState() {
    categorynamefind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime birthday = DateTime(widget.data.createdAt!.year,
        widget.data.createdAt!.month, widget.data.createdAt!.day);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(
              widget.data.jobTitle!,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Text("কানেক্ট আইডি: ${widget.data.jobId}"),
                SizedBox(
                  width: 10,
                ),
                Text("user: Tanvir Mahamud Shakil"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Text("Post: ${difference} day ago"),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(categoryname),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Text(
              widget.data.description!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ImagedialogBox(),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('images/post.jpg'),
                  Text(
                    '21+',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(7),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        size: 17,
                      ),
                      SizedBox(width: 5),
                      Text("এডিট করুন"),
                    ],
                  )),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationListPage(),
                      ));
                },
                child: Container(
                    padding: EdgeInsets.all(7),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          size: 17,
                        ),
                        SizedBox(width: 5),
                        Text("প্রার্থী"),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          size: 17,
                        ),
                        SizedBox(width: 5),
                        Text("মুছে ফেলুন"),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {
                  share();
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.share,
                          size: 17,
                        ),
                        SizedBox(width: 5),
                        Text("শেয়ার"),
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
