import 'package:flutter/material.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';

class HomeScreenpage extends StatefulWidget {
  const HomeScreenpage({Key? key}) : super(key: key);

  @override
  _HomeScreenpageState createState() => _HomeScreenpageState();
}

class _HomeScreenpageState extends State<HomeScreenpage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFDEAEC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        title: const Text(
          "মোঃ হাসান ইসলাম",
          style: TextStyle(fontSize: 14, fontFamily: 'Kalpurush'),
        ),
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("কানেক্ট"),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Searchpage(),
                    ));
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 5),
            width: size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Color(0xFFE51D20),
            ),
            child: Column(
              children: [
                const Text(
                  "কানেকশন এবং লিংক পাওয়ার এবং দেওয়ার সহজতম মাধ্যম",
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Kalpurush'),
                ),
                Text(
                  "যেকোনো ধরণের কাজ প্রজেক্ট ব্যবসা অথবা সাপ্লাই এর কাজের লিংক এবং কানেকশন পান যখন তখন যেখানে সেখানে",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 9,
                      color: Colors.white.withOpacity(0.7),
                      fontFamily: 'Kalpurush'),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          categorylist(),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: const [
                Text(
                  "মোট লিংক: ১৫",
                  style: TextStyle(fontFamily: 'Kalpurush'),
                ),
                Spacer(),
                Text(
                  "মোট লিংকদাতা: ২০",
                  style: TextStyle(fontFamily: 'Kalpurush'),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
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
    return Container(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Color(0xFFE51D20),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "ক্যাটাগরি ৩",
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
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Land in gazipur",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              const Text(
                "কানেক্ট আইডি: ৯",
                style: TextStyle(fontFamily: 'Kalpurush'),
              ),
              const Text(
                "জমি/প্রপার্টি",
                style: TextStyle(fontFamily: 'Kalpurush'),
              ),
              SizedBox(height: 10),
              DescriptionTextWidget(
                text:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              )
            ],
          ),
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
