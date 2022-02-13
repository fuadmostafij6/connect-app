import 'package:flutter/material.dart';

import '../membershipbuy.dart';

class Hundredtkpage extends StatefulWidget {
  const Hundredtkpage({Key? key}) : super(key: key);

  @override
  _HundredtkpageState createState() => _HundredtkpageState();
}

class _HundredtkpageState extends State<Hundredtkpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          detailsbox(name: "Follow", value: "10"),
          Divider(),
          detailsbox(name: "post Limit", value: "1"),
          Divider(),
          detailsbox(name: "Application", value: "1"),
          Divider(),
          detailsbox(name: "Category", value: "1"),
          Divider(),
          detailsbox(name: "Call", value: 'x'),
          Divider(),
          detailsbox(name: "Validation", value: "30 day"),
          Divider(),
          MaterialButton(
            color: Colors.grey[200],
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemeberShipBuyPage(),
                  ));
            },
            child: Text('নির্বাচন করুন'),
          )
        ],
      ),
    );
  }

  Widget detailsbox({String? name, String? value, IconData? icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          Text(
            name!,
          ),
          Spacer(),
          icon != null
              ? Icon(icon)
              : Text(
                  value!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
        ],
      ),
    );
  }
}
