import 'package:flutter/material.dart';

import '../../login.dart';

class Splashscreen5Page extends StatefulWidget {
  const Splashscreen5Page({Key? key}) : super(key: key);

  @override
  State<Splashscreen5Page> createState() => _Splashscreen5PageState();
}

class _Splashscreen5PageState extends State<Splashscreen5Page> {
  bool loading = false;

  @override
  void initState() {
    loading = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loading = false;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            "কানেক্ট",
            style: TextStyle(fontSize: 120, color: Color(0xFFE51D20)),
          ),
        ),
        
      ],
    );
  }
}
