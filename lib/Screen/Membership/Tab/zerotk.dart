import 'package:flutter/material.dart';

import '../membershipbuy.dart';

class Zerotkpage extends StatefulWidget {
  const Zerotkpage({Key? key}) : super(key: key);

  @override
  _ZerotkpageState createState() => _ZerotkpageState();
}

class _ZerotkpageState extends State<Zerotkpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          detailsbox(name: "Follow", value: "0"),
          Divider(),
          detailsbox(name: "post Limit", value: "1"),
          Divider(),
          detailsbox(name: "Application", value: "0"),
          Divider(),
          detailsbox(name: "Category", value: "0"),
          Divider(),
          detailsbox(name: "Call", value: 'x'),
          Divider(),
          detailsbox(name: "Validation", value: "1 day"),
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
