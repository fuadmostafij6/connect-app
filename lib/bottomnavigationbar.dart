import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtomNavigationbarPage extends StatefulWidget {
  final Function pageindex;
  const ButtomNavigationbarPage({Key? key, required this.pageindex})
      : super(key: key);

  @override
  _ButtomNavigationbarPageState createState() =>
      _ButtomNavigationbarPageState();
}

class _ButtomNavigationbarPageState extends State<ButtomNavigationbarPage> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 5),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: index == 1
                            ? Color(0xFFE51D20)
                            : Colors.transparent))),
            child: IconButton(
              onPressed: () {
                setState(() {
                  index = 1;
                  widget.pageindex(0);
                });
              },
              icon: index == 1
                  ? Image.asset(
                      'images/Home (1).png',
                      height: 30,
                    )
                  : Image.asset(
                      'images/home.png',
                      height: 20,
                    ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: index == 2
                            ? Color(0xFFE51D20)
                            : Colors.transparent))),
            child: IconButton(
              onPressed: () {
                setState(() {
                  index = 2;
                  widget.pageindex(1);
                });
              },
              icon: index == 2
                  ? Image.asset(
                      'images/Link (1).png',
                      height: 30,
                    )
                  : Image.asset(
                      'images/link.png',
                      height: 20,
                    ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: index == 3
                            ? Color(0xFFE51D20)
                            : Colors.transparent))),
            child: IconButton(
              onPressed: () {
                setState(() {
                  index = 3;
                  widget.pageindex(2);
                });
              },
              icon: index == 3
                  ? Image.asset(
                      'images/Dashboard.png',
                      height: 30,
                    )
                  : Image.asset(
                      'images/signal-status.png',
                      height: 20,
                    ),
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: FaIcon(FontAwesomeIcons.statu),
          // ),
        ],
      ),
    );
  }
}
