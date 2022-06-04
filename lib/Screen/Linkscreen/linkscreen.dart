import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:jobs_app/Screen/create_Job/createjob.dart';
import 'package:provider/provider.dart';

import '../../Model/Userjob/userjob.dart';
import '../../Provider/Userjob/userjob.dart';
import '../../Provider/home.dart';

class Linkscreenpage extends StatefulWidget {
  const Linkscreenpage({Key? key}) : super(key: key);

  @override
  _LinkscreenpageState createState() => _LinkscreenpageState();
}

class _LinkscreenpageState extends State<Linkscreenpage> {
  bool loading = false;

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
    Size size = MediaQuery.of(context).size;
    var box = Hive.box('login');
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateJobpage(),
                    ));
              },
              child: Container(
                height: size.height * 0.07,
                width: size.width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Color(0xFFE51D20),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.4),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
              ),
            )
          ],
        ),
      ),
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
          box.get('name'),
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
                      builder: (context) => Mainsearchpage(),
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
          : Column(
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
                //   child: const Text(
                //     "আমার লিংক সমূহ",
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                Flexible(child: alllinkservice())
              ],
            ),
    );
  }

  Widget alllinkservice() {
    final userjob = Provider.of<Userjobpage>(context);
    return userjob.userjob == null || userjob.userjob!.msg!.isEmpty
        ? Center(
            child: Text("No Job"),
          )
        : ListView.builder(
            itemCount: userjob.userjob!.msg!.length,
            itemBuilder: (context, index) {
              var data = userjob.userjob!.msg![index];
              return UserJob(data: data);
            },
          );
  }
}

class UserJob extends StatefulWidget {
  final Msgs data;
  const UserJob({Key? key, required this.data}) : super(key: key);

  @override
  _UserJobState createState() => _UserJobState();
}

class _UserJobState extends State<UserJob> {
  String categoryname = '';

  void categorynamefind() {
    final homeprovider = Provider.of<HomeProvider>(context, listen: false);
    for (var i = 0; i < homeprovider.allcategory!.msg!.length; i++) {
      if (widget.data.category == homeprovider.allcategory!.msg![i].catId) {
        setState(() {
          categoryname = homeprovider.allcategory!.msg![i].catName!;
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
          color: Color(0xFFFEF3F3),
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
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              Text(
                categoryname,
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              SizedBox(height: 10),
              DescriptionTextWidget(
                text: widget.data.description,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () {},
                      child: Text(
                        "এডিট করুন",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    const SizedBox(width: 10),
                    MaterialButton(
                      padding: const EdgeInsets.all(10),
                      color: const Color(0xFFE51D20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () {},
                      child: const Text(
                        "মুছে ফেলুন",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
