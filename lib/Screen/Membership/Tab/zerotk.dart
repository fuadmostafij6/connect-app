import 'package:flutter/material.dart';

import '../../../Model/PackageList/packagelist.dart';
import '../membershipbuy.dart';

class Zerotkpage extends StatefulWidget {
  final Package msg;
  const Zerotkpage({Key? key, required this.msg}) : super(key: key);

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
          detailsbox(name: "Post Limit", value: "${widget.msg.privilege!.postLimit}"),
          Divider(),
          detailsbox(name: "Apply Limit", value: "${widget.msg.privilege!.applyLimit}"),
          Divider(),
          detailsbox(name: "phone", value: "${widget.msg.privilege!.phone}"),
          Divider(),
          detailsbox(name: "Category", value: "${widget.msg.privilege!.category}"),
          Divider(),
          Divider(),
          MaterialButton(
            color: Colors.grey[200],
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemeberShipBuyPage(price: widget.msg.price!),
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
