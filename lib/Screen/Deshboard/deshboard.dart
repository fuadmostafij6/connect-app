import 'package:flutter/material.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';

class Deshboardpage extends StatefulWidget {
  const Deshboardpage({Key? key}) : super(key: key);

  @override
  _DeshboardpageState createState() => _DeshboardpageState();
}

class _DeshboardpageState extends State<Deshboardpage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
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
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: Column(
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
              "ড্যাশবোর্ড",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 22),
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
                          'images/user.png',
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
                          'images/user.png',
                          height: 60,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Link",
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
                    Column(
                      children: [
                        Image.asset(
                          'images/user.png',
                          height: 60,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Wallet",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "17880",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 450,
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  categorylist(),
                  DataTable(columns: const [
                    DataColumn(label: Text("SN")),
                    DataColumn(label: Text("Link")),
                    DataColumn(label: Text("Amount")),
                    DataColumn(label: Text("Status"))
                  ], rows: const [
                    DataRow(cells: [
                      DataCell(Text('01')),
                      DataCell(Text('Akamai techno....')),
                      DataCell(Text('93.9')),
                      DataCell(Text('Complete'))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('02')),
                      DataCell(Text('Micron')),
                      DataCell(Text('40.1')),
                      DataCell(Text('Complete'))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('03')),
                      DataCell(Text('First Horizon')),
                      DataCell(Text('66.4')),
                      DataCell(Text('Complete'))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('04')),
                      DataCell(Text('LSI')),
                      DataCell(Text('47.6')),
                      DataCell(Text('Complete'))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('05')),
                      DataCell(Text('Altera')),
                      DataCell(Text('39.9')),
                      DataCell(Text('Close'))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('06')),
                      DataCell(Text('Allegheny')),
                      DataCell(Text('33.0')),
                      DataCell(Text('Pending'))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('07')),
                      DataCell(Text('Musa Corporat')),
                      DataCell(Text('95.9')),
                      DataCell(Text('Complete'))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('08')),
                      DataCell(Text('First Horizon')),
                      DataCell(Text('85.0')),
                      DataCell(Text('Complete'))
                    ])
                  ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget categorylist() {
    return Container(
      height: 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Color(0xFFE51D20),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "ক্যাটাগরি ৩",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
