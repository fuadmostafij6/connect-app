import 'package:flutter/material.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';

class ApplicationListPage extends StatefulWidget {
  const ApplicationListPage({Key? key}) : super(key: key);

  @override
  _ApplicationListPageState createState() => _ApplicationListPageState();
}

class _ApplicationListPageState extends State<ApplicationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application List'),

        elevation: 0,
        backgroundColor: Color(0xFFE51D20),

        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(30.0),
        //   child: Container(
        //     height: 20,
        //     child: Text(
        //       "আমার লিংক সমূহ",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
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
      body: Column(
        children: [
          Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Test from Expert IT Solution',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: List.generate(3, (index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text((index + 1).toString()),
                              ),
                              Container(
                                child: Text('Name'),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => showdetailsdialog(),
                                  );
                                },
                                child: Container(
                                  child: Text("Details"),
                                ),
                              ),
                              Container(
                                child: Text("Message"),
                              )
                            ]),
                      ),
                      Divider()
                    ],
                  );
                }),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget showdetailsdialog() {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(
              'Details',
              style: TextStyle(fontSize: 18),
            ),
            Divider(),
            Container(padding: EdgeInsets.all(10), child: Text("Time")),
            Container(padding: EdgeInsets.all(10), child: Text("Date")),
            Container(padding: EdgeInsets.all(10), child: Text("File")),
          ],
        ),
      ),
    );
  }
}
