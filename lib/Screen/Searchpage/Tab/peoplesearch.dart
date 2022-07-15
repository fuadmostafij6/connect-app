import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Model/SearchUser/searchuser.dart';
import 'package:jobs_app/Provider/Profile/profile.dart';
import 'package:jobs_app/Provider/Search/search.dart';
import 'package:jobs_app/Screen/Profile/linkuserprofile.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../Const_value/apilink.dart';
import '../../../Provider/Follow/follow.dart';
import '../../Profile/postlinkuser.dart';

class PeopleSearchPage extends StatefulWidget {
  const PeopleSearchPage({Key? key}) : super(key: key);

  @override
  _PeopleSearchPageState createState() => _PeopleSearchPageState();
}

class _PeopleSearchPageState extends State<PeopleSearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final search = Provider.of<Searchprovider>(context);
    return Container(
      padding: EdgeInsets.only(left: 3, top: 3, right: 3),
      color: Colors.grey[300],
      child: search.searchuser != null
          ? GridView.builder(
              itemCount: search.searchuser!.msg!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.85),
              itemBuilder: (context, index) {
                var data = search.searchuser!.msg![index];
                return UserProfilelist(
                  data: data,
                );
              },
            )
          : Container(),
    );
  }
}

class UserProfilelist extends StatefulWidget {
  final Msg data;
  const UserProfilelist({Key? key, required this.data}) : super(key: key);

  @override
  _UserProfilelistState createState() => _UserProfilelistState();
}

class _UserProfilelistState extends State<UserProfilelist> {
  String? status = '';

  Future followstatus() async {
    var box = Hive.box('login');
    var headers = {
      'Cookie': 'ci_session=8b60b892cb6cdac140e0edd7f17a76733b8087b3'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/api/follow/followstatus?user_id=${box.get('userid')}&user_profile_id=${widget.data.userId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      setState(() {
        status = json['msg'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    followstatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('login');
    final profile = Provider.of<ProfileProvider>(context);
    final follow = Provider.of<FollowProvider>(context);

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostLinkuserprofile(
                  userid: widget.data.userId!,
                ),
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: widget.data.pic != null
                  ? CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://launch1.goshrt.com/uploads/${widget.data.pic}"),
                    )
                  : CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/Chat_list/3.jpg'),
                    ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(widget.data.fullName!,
                  style: TextStyle(fontFamily: 'Kalpurush')),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(widget.data.profileTagline!,
                  style: TextStyle(fontFamily: 'Kalpurush')),
            ),
            Container(
              child: InkWell(
                onTap: () {
                  if (status == "User can follow this user") {
                    follow
                        .followacton(
                            profileid: widget.data.userId.toString(),
                            status: 'add')
                        .then((value) => followstatus());
                  } else {
                    follow
                        .followacton(
                            profileid: widget.data.userId.toString(),
                            status: 'remove')
                        .then((value) => followstatus());
                  }
                },
                child: Text(
                  status == ""
                      ? ""
                      : status == "User can follow this user"
                          ? "অনুসরুন করুন"
                          : "অনুসরুন বাতিল করুন",
                  style: TextStyle(color: Colors.red, fontFamily: 'kalpurush'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
