import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> with TickerProviderStateMixin {
  TabController? tabController;

  List<Tab> tablist = [
    Tab(text: "About"),
    Tab(text: "About"),
    Tab(text: "About")
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Sagordpi',
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: tablist,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.green,
        ),
      ),
      body: listiteam(),
    );
  }

  Widget listiteam() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            height: 120,
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    child: Image.asset(
                      'images/download.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 15,
                            color: Colors.yellow,
                          ),
                          Text(
                            '5.0',
                            style: TextStyle(color: Colors.yellow),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "(7)",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Spacer(),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Text(
                        'Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15, height: 1.2),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'From',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '\$15',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
