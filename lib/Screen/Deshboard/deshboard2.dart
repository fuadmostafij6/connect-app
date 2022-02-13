import 'package:flutter/material.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
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
        title: Text("ড্যাশবোর্ড"),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("কানেক্ট"),
          ],
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
          IconButton(
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
              icon: Icon(Icons.menu)),
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
    return DataTable(
        columns: [
          DataColumn(label: Text('SN')),
          DataColumn(label: Text('Link')),
          DataColumn(label: Text('Count')),
          DataColumn(label: Text('Message')),
        ],
        rows: List.generate(20, (index) {
          return DataRow(cells: [
            DataCell(Text((index + 1).toString())),
            DataCell(Text('Category')),
            DataCell(Text("8")),
            DataCell(Text("Message"))
          ]);
        }));
  }
}
