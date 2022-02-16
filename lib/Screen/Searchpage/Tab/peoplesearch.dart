import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Model/SearchUser/searchuser.dart';
import 'package:jobs_app/Provider/Profile/profile.dart';
import 'package:jobs_app/Provider/Search/search.dart';
import 'package:jobs_app/Screen/Profile/linkuserprofile.dart';
import 'package:provider/provider.dart';

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
                  crossAxisCount: 2, childAspectRatio: 2 / 2.1),
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
  int follower = 0;

  void followcheck() {
    var box = Hive.box('login');
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    profile
        .followstatuscheck(
            userid: box.get('userid'), userprofileid: widget.data.userId)
        .then((value) {
      print(value['msg']);
      if (value['msg'] == 'Already following') {
        setState(() {
          follower = 0;
        });
      } else {
        setState(() {
          follower = 1;
        });
      }
    });

    print(follower);
  }

  Future refreshdata() async {
    var box = Hive.box('login');

    await Provider.of<ProfileProvider>(context, listen: false)
        .followstatuscheck(
            userid: box.get('userid'), userprofileid: widget.data.userId)
        .then((value) {
      print(value['msg']);
      if (value['msg'] == 'Already following') {
        setState(() {
          follower = 0;
          print(follower);
        });
      } else {
        setState(() {
          follower = 1;
          print(follower);
        });
      }
    });
  }

  @override
  void initState() {
    followcheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('login');
    final profile = Provider.of<ProfileProvider>(context);

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Linkuserprofile(
                  data: widget.data,
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
              child: MaterialButton(
                color: Colors.red,
                onPressed: follower == 0
                    ? () {
                        profile
                            .followaction(
                                action: 'remove',
                                userid: box.get('userid'),
                                userprofileid: widget.data.userId)
                            .then((value) {
                          refreshdata();
                        });
                        print('remove');
                      }
                    : () {
                        profile
                            .followaction(
                                action: 'add',
                                userid: box.get('userid'),
                                userprofileid: widget.data.userId)
                            .then((value) {
                          refreshdata();
                        });
                        print('add');
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.white,
                    ),
                    Text(
                      follower == 0 ? "অনুসরুন বাদ দিন" : "অনুসরুন করুন",
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Kalpurush'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
