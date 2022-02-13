import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:jobs_app/Provider/Search/search.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/apply_job.dart';
import 'package:jobs_app/Screen/home/Tab/recentfeed.dart';
import 'package:provider/provider.dart';
import 'package:jobs_app/Model/Search_Job/searchjob.dart';

class Searchpage2 extends StatefulWidget {
  const Searchpage2({Key? key}) : super(key: key);

  @override
  _Searchpage2State createState() => _Searchpage2State();
}

class _Searchpage2State extends State<Searchpage2> {
  @override
  Widget build(BuildContext context) {
    final search = Provider.of<Searchprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        backgroundColor: Color(0xFFE51D20),

        centerTitle: true,
        // leading: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text("কানেক্ট"),
        //   ],
        // ),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: Column(
        children: [
          searchpage(),
          search.searchJob == null
              ? Text(
                  "Search Job",
                  style: TextStyle(color: Colors.black.withOpacity(0.7)),
                )
              : Flexible(child: alllinkservice()),
        ],
      ),
    );
  }

  Widget searchpage() {
    final search = Provider.of<Searchprovider>(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: TextFormField(
        onChanged: (value) {
          if (value.isNotEmpty) {
            search
                .getsearchjob(keyword: value, context: context)
                .then((value) {});
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            hintText: "সার্চ করুন",
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[300]),
      ),
    );
  }

  Widget alllinkservice() {
    final search = Provider.of<Searchprovider>(context);
    return search.searchJob!.msg!.isEmpty
        ? Center(
            child: Text("No Job Found"),
          )
        : ListView.builder(
            itemCount: search.searchJob!.msg!.length,
            itemBuilder: (context, index) {
              var data = search.searchJob!.msg![index];
              return JobListcard(
                data: data,
              );
            },
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
                        Text("প্রস্তাবনা দিন"),
                      ],
                    ),
                  )),
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
                        Text("শেয়ার"),
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
