import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Provider/Jobdetails/jobdetails.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:provider/provider.dart';

class CreateJobpage extends StatefulWidget {
  const CreateJobpage({Key? key}) : super(key: key);

  @override
  _CreateJobpageState createState() => _CreateJobpageState();
}

class _CreateJobpageState extends State<CreateJobpage> {
  String? filename;

  String? jobtite, description, category, userid, contactnumber;

  @override
  Widget build(BuildContext context) {
    final jbdetails = Provider.of<JobDetailsProvider>(context);
    var box = Hive.box('login');
    return Scaffold(
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
        // leading: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text("কানেক্ট"),
        //   ],
        // ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Container(
            height: 20,
            child: Text(
              "লিংকঅ্যাপ",
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
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "আপনি যে কাজ/প্রজেক্ট-এর কানেকশন এবং লিংক দিতে চান তা এখানে লিপিবদ্ধ করুন",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            dropdowntext(),
            SizedBox(height: 10),
            Textbox(),
            SizedBox(height: 10),
            textform(),
            SizedBox(height: 10),
            filepicker(),
            SizedBox(height: 10),
            phoneTextbox(),
            MaterialButton(
              color: Color(0xFFE51D20),
              onPressed: () {
                jbdetails.newjobcreate(
                    category: category,
                    contactnumber: contactnumber ?? "",
                    description: description ?? "",
                    jobtite: jobtite ?? "",
                    context: context,
                    userid: box.get('userid'));
              },
              child: Text(
                "সাবমিট করুন",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Textbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 10), child: Text("(০২) শিরোনাম")),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                jobtite = value;
              });
            },
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
          ),
        )
      ],
    );
  }

  Widget dropdowntext() {
    final homeprovider = Provider.of<HomeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.all(10), child: Text("(০১) কাজের ক্যাটাগরি")),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownSearch<String>(
            mode: Mode.MENU,
            items:
                homeprovider.categorylist!.msg!.map((e) => e.catName!).toList(),
            dropdownSearchDecoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            onChanged: (value) {
              for (var i = 0; i < homeprovider.categorylist!.msg!.length; i++) {
                if (homeprovider.categorylist!.msg![i].catName == value) {
                  setState(() {
                    category = homeprovider.categorylist!.msg![i].catId;
                  });
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget filepicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 10, top: 4),
            child: Text("(০২) ফাইল যুক্ত করুন (ঐচ্ছিক)")),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    setState(() {
                      filename = result.files.single.name;
                    });
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(), color: Color(0xFFEFEFEF)),
                  child: Text("Choose File",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(width: 10),
              Text(filename ?? "No File Chosen")
            ],
          ),
        ),
      ],
    );
  }

  Widget textform() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            child: Text("(০৩) কাজের বর্ননা")),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
            maxLines: 5,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }

  Widget phoneTextbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("(০৫) কন্টাক নম্বর")),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                contactnumber = value;
              });
            },
            decoration: InputDecoration(
              isDense: true,
              hintText: "০১৯৩২৩৩১৭১৮",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
          ),
        )
      ],
    );
  }
}
