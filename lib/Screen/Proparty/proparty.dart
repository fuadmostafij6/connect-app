import 'package:flutter/material.dart';

class PropartyPage extends StatefulWidget {
  const PropartyPage({Key? key}) : super(key: key);

  @override
  _PropartyPageState createState() => _PropartyPageState();
}

class _PropartyPageState extends State<PropartyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "জমি/প্রপার্টি",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
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
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: alllinkservice(),
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
              Text("কানেক্ট দিয়েছেন: Test Name",
                  style: TextStyle(fontFamily: 'Kalpurush')),
              Row(
                children: [
                  Text("@DevOps", style: TextStyle(fontFamily: 'Kalpurush')),
                  Spacer(),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text("সময়: 11 মাস আগে ",
                          style: TextStyle(fontFamily: 'Kalpurush')))
                ],
              ),
              SizedBox(height: 5),
              const Text(
                "জমি/প্রপার্টি",
                style: TextStyle(fontFamily: 'Kalpurush'),
              ),
              SizedBox(height: 10),
              DescriptionTextWidget(
                text:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "প্রস্তাবনা দিন",
                      style: TextStyle(color: Color(0xFFE51D20), fontSize: 12),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color(0xFFE51D20),
                        // border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "বিস্তারিত দেখুন",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                ],
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
