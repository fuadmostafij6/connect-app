import 'package:flutter/material.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';

class Linkscreenpage extends StatefulWidget {
  const Linkscreenpage({Key? key}) : super(key: key);

  @override
  _LinkscreenpageState createState() => _LinkscreenpageState();
}

class _LinkscreenpageState extends State<Linkscreenpage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Stack(
          children: [
            InkWell(
              onTap: () {},
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
                      builder: (context) => Searchpage(),
                    ));
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: Column(
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
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          color: Color(0xFFFEF3F3),
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
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              Text(
                "জমি/প্রপার্টি",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              SizedBox(height: 10),
              DescriptionTextWidget(
                text:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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

    if (widget.text!.length > 60) {
      firstHalf = widget.text!.substring(0, 60);
      secondHalf = widget.text!.substring(60, widget.text!.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf!.isEmpty
          ? Text(firstHalf!)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(flag ? (firstHalf!) : (firstHalf! + secondHalf!)),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          flag ? ".....show more" : "show less",
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
