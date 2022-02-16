import 'package:flutter/material.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';

class Deshboard2page extends StatefulWidget {
  const Deshboard2page({Key? key}) : super(key: key);

  @override
  _Deshboard2pageState createState() => _Deshboard2pageState();
}

class _Deshboard2pageState extends State<Deshboard2page> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      endDrawer: DrawerPage(),
      appBar: AppBar(
        title: Text("ড্যাশবোর্ড",
            style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush')),
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        backgroundColor: const Color(0xFFE51D20),
        centerTitle: true,
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "কানেক্ট",
                style: TextStyle(fontFamily: 'Kalpurush', fontSize: 22),
              ),
            ),
          ],
        ),
        leadingWidth: 70,
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Mainsearchpage(),
                    ));
              },
              child: Icon(Icons.search)),
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const Searchpage(),
          //           ));
          //     },
          //     icon: Icon(Icons.search)),
          SizedBox(width: 5),
          InkWell(
              onTap: () {
                _key.currentState!.openEndDrawer();
              },
              child: Icon(Icons.menu)),
          SizedBox(width: 10),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: size.width,
                    height: size.height * 0.1,
                    child: Card(
                      child: Container(),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'images/Dashboard_icom/My Link.png',
                            height: 60,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "My Link",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "80",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'images/Dashboard_icom/Link.png',
                            height: 60,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Links",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "65",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),

                      // Column(
                      //   children: [
                      //     Image.asset(
                      //       'images/Dashboard_icom/Wallet.png',
                      //       height: 60,
                      //     ),
                      //     SizedBox(height: 5),
                      //     Text(
                      //       "Wallet",
                      //       style: TextStyle(
                      //           fontSize: 20, fontWeight: FontWeight.bold),
                      //     ),
                      //     Text(
                      //       "17,880",
                      //       style: TextStyle(
                      //           fontSize: 20, fontWeight: FontWeight.bold),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            ),
            datatable()
          ],
        ),
      ),
    );
  }

  Widget datatable() {
    return FittedBox(
      child: DataTable(
          columnSpacing: MediaQuery.of(context).size.width * 0.2,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Color(0xFFE51D20)),
          columns: [
            DataColumn(
                label: Text('SN',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Kalpurush'))),
            DataColumn(
                label: Text('Link',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Kalpurush'))),
            DataColumn(
                label: Text('Count',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Kalpurush'))),
            DataColumn(
                label: Text('Message',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Kalpurush'))),
          ],
          rows: List.generate(20, (index) {
            return DataRow(cells: [
              DataCell(Text((index + 1).toString(),
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'Kalpurush'))),
              DataCell(Text('Category',
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'Kalpurush'))),
              DataCell(Text("8",
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'Kalpurush'))),
              DataCell(Text("Message",
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'Kalpurush')))
            ]);
          })),
    );
  }
}
