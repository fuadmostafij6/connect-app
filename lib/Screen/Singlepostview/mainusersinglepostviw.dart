import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Model/Userjob/userjob.dart';

import '../Linkscreen/mylinkscreen.dart';

class MainuserSinglePostView extends StatefulWidget {
  final Msgs data;
  final int index;
  const MainuserSinglePostView(
      {Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<MainuserSinglePostView> createState() => _MainuserSinglePostViewState();
}

class _MainuserSinglePostViewState extends State<MainuserSinglePostView> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('login');
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        backgroundColor: Color(0xFFE51D20),
        centerTitle: true,
        title: Text(
          box.get('name'),
          style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush'),
        ),
      ),
      body: SingleChildScrollView(
          child: JobListcard(data: widget.data, index: widget.index)),
    );
  }
}
