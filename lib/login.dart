import 'package:flutter/material.dart';
import 'package:jobs_app/homepage.dart';

import 'Screen/Form/registation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fromkey = GlobalKey<FormState>();

  bool checkbox = false;

  void validation() {
    final from = _fromkey.currentState;
    if (from!.validate()) {
      from.save();
      redirecthomepage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        title: Text(
          "কানেক্ট",
          style: TextStyle(fontFamily: 'Kalpurush'),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu))
        ],
      ),
      body: Form(
        key: _fromkey,
        child: Column(
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
              child: const Text(
                "কাজ পেতে লগইন করুন",
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: 'Kalpurush'),
              ),
            ),
            formbox(
              name: "ইমেইল *",
              hinttext: "আপনার ইমেইল",
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
              },
            ),
            SizedBox(height: 10),
            formbox(
              name: "পাসওয়ার্ড *",
              hinttext: "**************",
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                    value: checkbox,
                    onChanged: (value) {
                      setState(() {
                        checkbox = value!;
                      });
                    }),
                Text(
                  "লগইন সেভ রাখুন",
                  style: TextStyle(fontFamily: 'Kalpurush'),
                )
              ],
            ),
            InkWell(
              onTap: () {
                validation();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: size.width * 0.3,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFE51D20)),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("লগইন করুন",
                        style:
                            TextStyle(fontSize: 13, fontFamily: 'Kalpurush')),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward,
                      size: 19,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 2,
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFFE51D20),
                      Color(0xFFE51D20).withOpacity(0)
                    ], begin: Alignment.centerRight, end: Alignment.centerLeft),
                  ),
                ),
                Container(
                  height: 2,
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xFFE51D20),
                      const Color(0xFFE51D20).withOpacity(0)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "এখানে নতুন?",
              style: TextStyle(fontFamily: 'Kalpurush'),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                redirectpage(const RegistationPage());
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: size.width * 0.4,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFE51D20)),
                    borderRadius: BorderRadius.circular(5)),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("একাউন্ট তৈরি করুন",
                          style:
                              TextStyle(fontSize: 13, fontFamily: 'Kalpurush')),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        size: 19,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formbox({
    String? name,
    String? hinttext,
    FormFieldValidator<String>? validator,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name!,
            style: TextStyle(fontFamily: 'Kalpurush'),
          ),
          TextFormField(
            validator: validator,
            decoration: InputDecoration(
                errorStyle: const TextStyle(height: 0),
                isDense: true,
                hintStyle: TextStyle(fontFamily: 'Kalpurush'),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 5),
                hintText: hinttext),
          )
        ],
      ),
    );
  }

  void redirectpage(Widget pagename) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => pagename));
  }

  void redirecthomepage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ),
        (route) => false);
  }
}
