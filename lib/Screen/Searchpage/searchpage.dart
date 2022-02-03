import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        backgroundColor: Color(0xFFE51D20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Text(
          "মোঃ হাসান ইসলাম",
          style: TextStyle(fontSize: 14),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Container(
            child: Column(
              children: [
                const Text(
                  "আপনার লিংক সার্চ করুন",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "যেকোনো ধরণের কাজ প্রজেক্ট ব্যবসা অথবা সাপ্লাই এর কাজের লিংক এবং কানেকশন পান যখন তখন যেখানে সেখানে",
                  style: TextStyle(
                      fontSize: 8, color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        ),
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
          //         "আপনার লিংক সার্চ করুন",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       Text(
          //         "যেকোনো ধরণের কাজ প্রজেক্ট ব্যবসা অথবা সাপ্লাই এর কাজের লিংক এবং কানেকশন পান যখন তখন যেখানে সেখানে",
          //         style: TextStyle(
          //             fontSize: 8, color: Colors.white.withOpacity(0.7)),
          //       ),
          //     ],
          //   ),
          // ),
          searchpage(),
          Flexible(child: alllinkservice()),
        ],
      ),
    );
  }

  Widget searchpage() {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextFormField(
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
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          color: Color(0xFFF8C2C2),
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
              const Text("কানেক্ট আইডি ৯"),
              const Text("জমি/প্রপার্টি"),
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
