import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jobs_app/Provider/Profile/profile.dart';
import 'package:jobs_app/Screen/ApplicationList/applicationlist.dart';
import 'package:jobs_app/Screen/Following/follower.dart';
import 'package:jobs_app/Screen/Following/following.dart';
import 'package:jobs_app/Screen/Form/login.dart';
import 'package:jobs_app/Screen/Linkscreen/applicationlist.dart';
import 'package:jobs_app/Screen/Membership/membershipiteam2.dart';
import 'package:jobs_app/Screen/Profile/profileedit.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  int btntab = 1;

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    var box = Hive.box('login');
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          // child: Container(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       InkWell(
          //         onTap: () {
          //           // redirectpage(NewBookPage());
          //           redirectpage(AddbookBasicPage());
          //         },
          //         child: Row(
          //           children: const [
          //             Padding(
          //               padding: EdgeInsets.all(10.0),
          //               child: Text("New Book Add"),
          //             )
          //           ],
          //         ),
          //       ),
          //       InkWell(
          //         onTap: () {
          //           redirectpage(MyBookPage());
          //         },
          //         child: Row(
          //           children: const [
          //             Padding(
          //               padding: EdgeInsets.all(10.0),
          //               child: Text("My Book"),
          //             )
          //           ],
          //         ),
          //       ),
          //       InkWell(
          //         onTap: () {
          //           redirectpage(AllgenreALluserPage());
          //         },
          //         child: Row(
          //           children: const [
          //             Padding(
          //               padding: EdgeInsets.all(10.0),
          //               child: Text("Genre"),
          //             )
          //           ],
          //         ),
          //       ),
          //       InkWell(
          //         onTap: () {
          //           // redirectpage(AllShelvesPage());
          //         },
          //         child: Row(
          //           children: const [
          //             Padding(
          //               padding: EdgeInsets.all(10.0),
          //               child: Text("Shelves"),
          //             )
          //           ],
          //         ),
          //       ),
          //       // InkWell(
          //       //   onTap: () {
          //       //     redirectpage(StatisticsPage());
          //       //   },
          //       //   child: Row(
          //       //     children: const [
          //       //       Padding(
          //       //         padding: EdgeInsets.all(10.0),
          //       //         child: Text("Statistics"),
          //       //       )
          //       //     ],
          //       //   ),
          //       // ),
          //       InkWell(
          //         onTap: () {
          //           redirectpage(WishListPage());
          //         },
          //         child: Row(
          //           children: const [
          //             Padding(
          //               padding: EdgeInsets.all(10.0),
          //               child: Text("Wish List"),
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFFE51D20), Color(0xFFE51D20)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        SizedBox(width: 25),
                        Container(
                            child: CircleAvatar(
                          minRadius: 35,
                          backgroundImage: AssetImage(
                            "images/Chat_list/2.jpg",
                          ),
                        )),
                        SizedBox(width: 10),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                box.get('name'),
                                style: TextStyle(
                                    fontFamily: 'Kalpurush',
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileEditPage(
                                      company: profile
                                          .profile!.msg!.userData!.companyName,
                                      name: box.get('name'),
                                      number: profile
                                          .profile!.msg!.userData!.phone!,
                                      profiletag: profile.profile!.msg!
                                          .userData!.profileTagline,
                                    ),
                                  ));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
                // button(
                //   onTap: () {
                //     redirectpage(const AddbookBasicPage());
                //   },
                //   name: 'Add Books',
                // ),
                SizedBox(height: 5),
                button(
                  name2: "বাংলা",
                  onTap: () {
                    redirectpage(Membershipiteam2page());
                  },
                  name: 'Language',
                ),
                Divider(),
                button(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    redirectpage(Membershipiteam2page());
                  },
                  name: 'Membership Type',
                ),
                Divider(),
                button(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    redirectpage(FollowerPage());
                  },
                  name: 'Follower',
                ),
                Divider(),
                button(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    redirectpage(FollowingPage());
                  },
                  name: 'Following',
                ),
                Divider(),
                button(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    redirectpage(ApplicationList());
                  },
                  name: 'Application List',
                ),

                Divider(),
                button(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileEditPage(
                            company:
                                profile.profile!.msg!.userData!.companyName,
                            name: box.get('name'),
                            number: profile.profile!.msg!.userData!.phone!,
                            profiletag:
                                profile.profile!.msg!.userData!.profileTagline,
                          ),
                        ));
                  },
                  name: 'Profile Edit',
                ),
                Divider(),

                // button(
                //   onTap: () {
                //     // redirectpage(AllcategoryPage());
                //   },
                //   name: 'Hidden Rack',
                // ),
                // button(onTap: () {}, name: 'Merge', textcolor: Colors.grey),

                button(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {},
                  name: 'FAQ',
                ),
                Divider(),
                button(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {},
                  name: 'About',
                ),
                Divider(),
                button(
                  icon: Icons.arrow_forward_ios,
                  onTap: () {},
                  name: 'Website',
                ),
                Divider(),

                button(
                  onTap: () {
                    box.clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                  name: 'Log Out',
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button(
      {GestureTapCallback? onTap,
      String? name,
      Color? color,
      IconData? icon,
      String? name2,
      Color? textcolor}) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 2),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // color: Colors.grey[100],
        // color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 15),
            child: Row(
              children: [
                Text(
                  name!,
                  style: TextStyle(
                      color: textcolor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kalpurush'),
                ),
                Spacer(),
                icon != null
                    ? Icon(
                        icon,
                        color: Colors.grey[600],
                      )
                    : Text(
                        name2 ?? "",
                        style: TextStyle(fontFamily: 'Kalpurush', fontSize: 17),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void redirectpage(Widget pagename) {
    Navigator.push(context, _createRoute(pagename));
  }

  Route _createRoute(Widget pagename) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pagename,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // const begin = Offset(0.0, 1.0);
        // const end = Offset.zero;
        // const curve = Curves.ease;

        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
