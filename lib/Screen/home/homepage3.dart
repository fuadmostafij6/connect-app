import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Apply_job/apply_job.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:jobs_app/Screen/home/postdetails.dart';
import 'package:provider/provider.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({Key? key}) : super(key: key);

  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> with TickerProviderStateMixin {
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
    var box = Hive.box('login');
    return Scaffold(
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
        title: Text(
          box.get('name'),
          style: TextStyle(fontSize: 14),
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
                      builder: (context) => const Mainsearchpage(),
                    ));
              },
              icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : listiteam(),
    );
  }

  Widget listiteam() {
    final homeprovider = Provider.of<HomeProvider>(context);
    return ListView.builder(
      itemCount: homeprovider.joblist!.msg!.length,
      itemBuilder: (context, index) {
        var data = homeprovider.joblist!.msg![index];
        return Card(
          child: Container(
            height: 120,
            child: Row(
              children: [
                Container(
                  width: 130,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    child: Image.asset(
                      'images/Splash.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.star,
                      //       size: 15,
                      //       color: Colors.yellow,
                      //     ),
                      //     Text(
                      //       '5.0',
                      //       style: TextStyle(color: Colors.yellow),
                      //     ),
                      //     SizedBox(width: 5),
                      //     Text(
                      //       "(7)",
                      //       style: TextStyle(color: Colors.grey),
                      //     ),
                      //     Spacer(),
                      //     Icon(
                      //       Icons.favorite,
                      //       color: Colors.red,
                      //     )
                      //   ],
                      // ),
                      Text(
                        data.jobTitle!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            height: 1.2,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          height: 1.2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              child: MaterialButton(
                            color: data.status == "0"
                                ? Colors.grey
                                : Color(0xFFE51D20),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ApplyjobPage(
                                      jobid: data.jobId!,
                                    ),
                                  ));
                            },
                            child: Text(
                              "প্রস্তাবনা দিন",
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )),
                          SizedBox(width: 10),
                          Flexible(
                              child: MaterialButton(
                            color: Color(0xFFE51D20),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PostDetailsPage(jobid: data.jobId!),
                                  ));
                            },
                            child: Text(
                              "বিস্তারিত দেখুন",
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )),
                        ],
                      )
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Text(
                      //       'From',
                      //       style: TextStyle(
                      //           fontSize: 13,
                      //           color: Colors.black.withOpacity(0.6)),
                      //     ),
                      //     SizedBox(width: 5),
                      //     Text(
                      //       '\$15',
                      //       style: TextStyle(
                      //           fontSize: 17, fontWeight: FontWeight.bold),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
