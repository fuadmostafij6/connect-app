import 'package:flutter/material.dart';
import 'package:jobs_app/Const_value/textfielddropdown.dart';
import 'package:jobs_app/Const_value/textfrom.dart';

class ProfileEditPage extends StatefulWidget {
  final String? name;
  final String? email;
  final String? number;
  const ProfileEditPage({Key? key, this.name, this.email, this.number})
      : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Edit'),
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
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.only(top: 5),
                child: TextfromPage(
                  initialValue: widget.name,
                  name: "আপনার নাম",
                  hinttext: "আপনার নাম",
                  onSaved: (value) {},
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Flexible(
                      child: TextfromPage(
                        initialValue: widget.email,
                        name: "আপনার ইমেইল",
                        hinttext: "আপনার ইমেইল",
                        onSaved: (value) {},
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 71,
                      child: TextfieldDropdown(
                        name: "সিকিউরিটি",
                        hinttext: "সিকিউরিটি",
                        items: ["Private", 'Public'],
                        onSaved: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Flexible(
                      child: TextfromPage(
                        initialValue: widget.number,
                        name: "ফোন নম্বর",
                        hinttext: "ফোন নম্বর",
                        onSaved: (value) {},
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 71,
                      child: TextfieldDropdown(
                        name: "সিকিউরিটি",
                        hinttext: "সিকিউরিটি",
                        items: ["Private", 'Public'],
                        onSaved: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: MaterialButton(
                elevation: 1,
                color: Colors.white,
                onPressed: () {},
                child: Text("আপডেট প্রোফাইল"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
