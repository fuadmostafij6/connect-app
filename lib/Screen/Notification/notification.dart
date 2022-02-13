import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var box = Hive.box('login');
    return Scaffold(
      endDrawer: DrawerPage(),
      appBar: AppBar(
        title: Text('নোটিফিকেশন'),
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Searchpage(),
                //     ));
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('images/Notification (1).png'),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/Chat_list/3.jpg'),
                          radius: 25,
                          backgroundColor: Colors.red,
                        ),
                        SizedBox(width: 5),
                        CircleAvatar(
                          backgroundImage: AssetImage('images/Chat_list/1.jpg'),
                          radius: 25,
                          backgroundColor: Colors.amberAccent,
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    // const Text(
                    //     "Joshua and Jake Madsen Like a Photo From Malik"),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Joshua ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'and '),
                          TextSpan(
                              text: 'Jake Madsen ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'Like a Photo From Malik'),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('images/Notification (1).png'),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/Chat_list/3.jpg'),
                          radius: 25,
                          backgroundColor: Colors.red,
                        ),
                        SizedBox(width: 5),
                        // CircleAvatar(
                        //   backgroundImage: AssetImage('images/Chat_list/1.jpg'),
                        //   radius: 25,
                        //   backgroundColor: Colors.amberAccent,
                        // )
                      ],
                    ),
                    SizedBox(height: 5),
                    // const Text(
                    //     "Joshua and Jake Madsen Like a Photo From Malik"),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Recent tweet from ',
                          ),
                          TextSpan(
                              text: 'Jake Madsen ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('images/Notification (1).png'),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/Chat_list/3.jpg'),
                          radius: 25,
                          backgroundColor: Colors.red,
                        ),
                        SizedBox(width: 5),
                        // CircleAvatar(
                        //   backgroundImage: AssetImage('images/Chat_list/1.jpg'),
                        //   radius: 25,
                        //   backgroundColor: Colors.amberAccent,
                        // )
                      ],
                    ),
                    SizedBox(height: 5),
                    // const Text(
                    //     "Joshua and Jake Madsen Like a Photo From Malik"),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'musli ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: 'Retweetet a photo from ',
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('images/Notification (1).png'),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('images/Chat_list/3.jpg'),
                              radius: 25,
                              backgroundColor: Colors.red,
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('images/Chat_list/1.jpg'),
                              radius: 25,
                              backgroundColor: Colors.amberAccent,
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        // const Text(
                        //     "Joshua and Jake Madsen Like a Photo From Malik"),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: 'Recent tweet from '),
                              TextSpan(
                                  text: 'Joshua ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: 'and '),
                              TextSpan(
                                  text: 'Jake Madsen ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.1,
                  color: Colors.white.withOpacity(0.5),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
