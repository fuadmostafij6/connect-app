import 'package:flutter/material.dart';
import 'package:jobs_app/Model/job_List/joblist.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:provider/provider.dart';

class HomeScreenpage extends StatefulWidget {
  const HomeScreenpage({Key? key}) : super(key: key);

  @override
  _HomeScreenpageState createState() => _HomeScreenpageState();
}

class _HomeScreenpageState extends State<HomeScreenpage> {
  Future loaddata() async {
    await Provider.of<HomeProvider>(context, listen: false).getcategorylist();
    await Provider.of<HomeProvider>(context, listen: false).getjoblist();
  }

  bool loading = false;

  @override
  void initState() {
    loading = true;
    loaddata().then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeprovider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFFDEAEC),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          child: const Image(
            image: AssetImage(
              'images/Top Bar illustration Solid.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor: Color(0xFFE51D20),
        title: const Text(
          "মোঃ হাসান ইসলাম",
          style: TextStyle(fontSize: 14, fontFamily: 'Kalpurush'),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Column(
            children: [
              const Text(
                "কানেকশন এবং লিংক পাওয়ার এবং দেওয়ার সহজতম মাধ্যম",
                style: TextStyle(color: Colors.white, fontFamily: 'Kalpurush'),
              ),
              Text(
                "যেকোনো ধরণের প্রজেক্ট, ব্যবসা, সাপ্লাই এর কাজের লিংক এবং কানেকশন পান যখন তখন",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.7),
                    fontFamily: 'Kalpurush'),
              )
            ],
          ),
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("কানেক্ট"),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Searchpage(),
                    ));
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE51D20),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   alignment: Alignment.center,
                //   padding: const EdgeInsets.only(bottom: 5),
                //   width: size.width,
                //   decoration: const BoxDecoration(
                //     borderRadius: BorderRadius.only(
                //         bottomLeft: Radius.circular(10),
                //         bottomRight: Radius.circular(10)),
                //     color: Color(0xFFE51D20),
                //   ),
                //   child: Column(
                //     children: [
                //       const Text(
                //         "কানেকশন এবং লিংক পাওয়ার এবং দেওয়ার সহজতম মাধ্যম",
                //         style:
                //             TextStyle(color: Colors.white, fontFamily: 'Kalpurush'),
                //       ),
                //       Text(
                //         "যেকোনো ধরণের কাজ প্রজেক্ট ব্যবসা অথবা সাপ্লাই এর কাজের লিংক এবং কানেকশন পান যখন তখন যেখানে সেখানে",
                //         overflow: TextOverflow.ellipsis,
                //         style: TextStyle(
                //             fontSize: 9,
                //             color: Colors.white.withOpacity(0.7),
                //             fontFamily: 'Kalpurush'),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(height: 10),
                Container(
                    margin: EdgeInsets.only(left: 10), child: categorylist()),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Text(
                        "মোট লিংক: ${homeprovider.joblist!.msg!.length}",
                        style: TextStyle(fontFamily: 'Kalpurush'),
                      ),
                      Spacer(),
                      Text(
                        "মোট লিংকদাতা: 20",
                        style: TextStyle(fontFamily: 'Kalpurush'),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: const Text(
                    "লিংক সমূহ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Kalpurush',
                      color: Color(0xFFE51D20),
                    ),
                  ),
                ),
                Expanded(child: alllinkservice()),
              ],
            ),
    );
  }

  Widget categorylist() {
    final homeprovider = Provider.of<HomeProvider>(context);
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: homeprovider.categorylist!.msg!.length,
        itemBuilder: (context, index) {
          var data = homeprovider.categorylist!.msg![index];
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Color(0xFFE51D20),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  data.catName!,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'Kalpurush'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget alllinkservice() {
    final homeprovider = Provider.of<HomeProvider>(context);
    return ListView.builder(
      itemCount: homeprovider.joblist!.msg!.length,
      itemBuilder: (context, index) {
        var data = homeprovider.joblist!.msg![index];
        return JobListPage(
          data: data,
        );
      },
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String? text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text!.length > 40) {
      firstHalf = widget.text!.substring(0, 40);
      secondHalf = widget.text!.substring(40, widget.text!.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf!.isEmpty
          ? Text(
              firstHalf!,
              maxLines: 2,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                flag
                    ? Row(
                        children: [
                          Text(
                            firstHalf!,
                          ),
                          Spacer(),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  flag = !flag;
                                });
                              },
                              child: Text(
                                "    ...show more",
                                style: TextStyle(
                                    color: Color(0xFFE51D20).withOpacity(0.8)),
                              ))
                        ],
                      )
                    : Text(
                        flag ? (firstHalf!) : (firstHalf! + secondHalf!),
                      ),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          flag ? "" : "show less",
                          style: TextStyle(
                              color: Color(0xFFE51D20).withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}

class JobListPage extends StatefulWidget {
  final Msg data;
  const JobListPage({Key? key, required this.data}) : super(key: key);

  @override
  _JobListPageState createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
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

  @override
  void initState() {
    categorynamefind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 1,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.jobTitle!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "কানেক্ট আইডি: ${widget.data.jobId}",
                style: TextStyle(fontFamily: 'Kalpurush'),
              ),
              Text(
                categoryname,
                style: TextStyle(fontFamily: 'Kalpurush'),
              ),
              SizedBox(height: 10),
              DescriptionTextWidget(
                text: widget.data.description,
              )
            ],
          ),
        ),
      ),
    );
  }
}
