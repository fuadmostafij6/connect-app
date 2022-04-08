import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Const_value/textfielddropdown.dart';
import 'package:jobs_app/Const_value/textfrom.dart';
import 'package:jobs_app/Provider/Profile/profile.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  final String? name;
  final String? profiletag;
  final String? number;
  final String? company;
  const ProfileEditPage(
      {Key? key, this.name, this.number, this.profiletag, this.company})
      : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController name = TextEditingController();
  TextEditingController profiletag = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  void initState() {
    name.text = widget.name!;
    profiletag.text = widget.profiletag!;
    phone.text = widget.number!;
    company.text = widget.company!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    var box = Hive.box('login');
    print(box.get('userid'));
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: TextfromPage(
                    controller: name,
                    name: "আপনার নাম",
                    hinttext: "আপনার নাম",
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: TextfromPage(
                    controller: profiletag,
                    name: "প্রোফাইল ট্যাগ লাইন",
                    hinttext: "প্রোফাইল ট্যাগ লাইন",
                    onSaved: (value) {},
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: TextfromPage(
                    controller: phone,
                    name: "ফোন",
                    hinttext: "ফোন",
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: TextfromPage(
                    controller: company,
                    name: "কোম্পানি",
                    hinttext: "কোম্পানি",
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: TextfromPage(
                    controller: oldpassword,
                    name: "পুরাতন পাসওয়ার্ড ",
                    hinttext: "পুরাতন পাসওয়ার্ড ",
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: TextfromPage(
                    controller: newpassword,
                    name: "নতুন পাসওয়ার্ড",
                    hinttext: "নতুন পাসওয়ার্ড",
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: TextfromPage(
                    controller: confirmpassword,
                    name: "পুনরায় নতুন পাসওয়ার্ড দিন",
                    hinttext: "পুনরায় নতুন পাসওয়ার্ড দিন",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: MaterialButton(
                  elevation: 1,
                  color: Colors.white,
                  onPressed: () {
                    profile
                        .profileupdate(
                          company: company.text,
                          confirmpass: confirmpassword.text,
                          name: name.text,
                          newpass: newpassword.text,
                          oldpass: oldpassword.text,
                          phone: phone.text,
                          profiletag: profiletag.text,
                        )
                        .then((value) => profile.getprofileinfo());
                  },
                  child: Text("আপডেট প্রোফাইল"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
