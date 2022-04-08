import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Provider/UserPrevlies/userprevilies.dart';
import 'package:jobs_app/Screen/Form/login.dart';
import 'package:jobs_app/Screen/Membership/membershipiteam2.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Profile/profileedit.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

import '../../Provider/Profile/profile.dart';
import '../Membership/membeshipiteam.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  late List<Animal> animals = [
    Animal(id: 1, name: "বড় প্রকল্প সমূহ"),
    Animal(id: 2, name: "জমি/প্রপার্টি"),
    Animal(id: 3, name: "ব্যাংকিং ও বিনিয়োগ"),
    Animal(id: 4, name: "প্রিন্সিপাল"),
    Animal(id: 5, name: "বিদেশী প্রিন্সিপাল"),
    Animal(id: 6, name: "মেশিনারিজ"),
    Animal(id: 7, name: "সার্ভিসেস"),
  ];

  @override
  void initState() {
    loading = true;
    Provider.of<ProfileProvider>(context, listen: false)
        .getprofileinfo()
        .then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    Size size = MediaQuery.of(context).size;
    var box = Hive.box('login');
    return Scaffold(
      key: _key,
      endDrawer: DrawerPage(),
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush')),
        elevation: 0,
        backgroundColor: Color(0xFFE51D20),
        flexibleSpace: Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "কানেক্ট",
                style: TextStyle(fontFamily: 'Kalpurush', fontSize: 22),
              ),
            ),
          ],
        ),
        leadingWidth: 70,
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Mainsearchpage(),
                    ));
              },
              child: Icon(Icons.search)),

          SizedBox(width: 5),
          InkWell(
              onTap: () {
                _key.currentState!.openEndDrawer();
              },
              child: Icon(Icons.menu)),
          SizedBox(width: 10),
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.38,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFFEF3F3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'images/Chat_list/2.jpg',
                              ),
                              radius: 50,
                              backgroundColor: Color(0xFFFF5428),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      box.get('name'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'Kalpurush'),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileEditPage(
                                                company: profile.profile!.msg!
                                                    .userData!.companyName,
                                                name: box.get('name'),
                                                number: profile.profile!.msg!
                                                    .userData!.phone!,
                                                profiletag: profile
                                                    .profile!
                                                    .msg!
                                                    .userData!
                                                    .profileTagline,
                                              ),
                                            ));
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Color(0xFFE51F22),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Text(
                                  "@${box.get('name')}",
                                  style: TextStyle(
                                      color: Color(0xFF484649),
                                      fontFamily: 'Kalpurush'),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                child: Text(
                                  profile
                                      .profile!.msg!.userData!.profileTagline!,
                                  style: TextStyle(
                                      color: Color(0xFFEB5456),
                                      fontFamily: 'Kalpurush'),
                                ),
                              ),

                              Row(
                                children: [
                                  Icon(Icons.email),
                                  SizedBox(width: 5),
                                  Text(
                                    box.get('email'),
                                    style: TextStyle(fontFamily: 'Kalpurush'),
                                  ),
                                  Spacer(),
                                  MaterialButton(
                                    elevation: 1,
                                    color: Colors.grey[100],
                                    onPressed: () {},
                                    child: Text(
                                      "Message",
                                      style: TextStyle(fontFamily: 'Kalpurush'),
                                    ),
                                  )
                                ],
                              ),
                              // s
                              Row(
                                children: [
                                  Icon(Icons.phone),
                                  SizedBox(width: 5),
                                  Text(
                                    profile.profile!.msg!.userData!.phone!,
                                    style: TextStyle(fontFamily: 'Kalpurush'),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              // Row(
                              //   children: [
                              //     Text("ভেরিফাইড মেম্বার"),
                              //     SizedBox(width: 5),
                              //     Container(
                              //       padding: EdgeInsets.all(5),
                              //       decoration: BoxDecoration(
                              //           color: profile.profile!.msg!.userData!
                              //                       .verifiedMember ==
                              //                   '0'
                              //               ? Colors.grey
                              //               : Color(0xFFE94244),
                              //           borderRadius:
                              //               BorderRadius.circular(100)),
                              //       child: Icon(
                              //         Icons.favorite,
                              //         color: Colors.white,
                              //         size: 17,
                              //       ),
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          "আপনার নির্বাচিত ক্যাটাগরি সমূহ",
                          style: TextStyle(fontFamily: 'Kalpurush'),
                        ),
                        Spacer(),
                        Icon(Icons.edit, color: Color(0xFFE51F22))
                      ],
                    ),
                  ),
                  categorybox(),
                  // MultiSelectChipField(

                  //   items: animals
                  //       .map((animal) =>
                  //           MultiSelectItem<Animal>(animal, animal.name!))
                  //       .toList(),
                  //   initialValue: [animals[4], animals[7], animals[9]],
                  //   title: Text("Animals"),
                  //   headerColor: Colors.blue.withOpacity(0.5),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.blue, width: 1.8),
                  //   ),
                  //   selectedChipColor: Colors.blue.withOpacity(0.5),
                  //   selectedTextStyle: TextStyle(color: Colors.blue[800]),
                  //   onTap: (values) {
                  //     //_selectedAnimals4 = values;
                  //   },
                  // ),
                  // MultiSelectChipDisplay(
                  //   decoration: BoxDecoration(color: Colors.grey[200]),
                  //   items: animals
                  //       .map((animal) =>
                  //           MultiSelectItem<Animal>(animal, animal.name!))
                  //       .toList(),
                  //   onTap: (p0) {
                  //     print(p0);
                  //   },
                  // ),
                  // MultiSelectBottomSheetField(
                  //   initialChildSize: 0.4,
                  //   listType: MultiSelectListType.LIST,
                  //   searchable: true,
                  //   buttonText: Text("Favorite Animals"),
                  //   title: Text("Animals"),
                  //   items: animals
                  //       .map((animal) =>
                  //           MultiSelectItem<Animal>(animal, animal.name!))
                  //       .toList(),
                  //   onConfirm: (values) {
                  //     // _selectedAnimals2 = values;
                  //   },
                  //   chipDisplay: MultiSelectChipDisplay(
                  //     onTap: (value) {
                  //       setState(() {
                  //         // _selectedAnimals2.remove(value);
                  //       });
                  //     },
                  //   ),
                  // ),

                  // Container(
                  //   margin: EdgeInsets.all(20),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Text("আপনার নির্বাচিত ক্যাটাগরি সমূহ"),
                  //           Spacer(),
                  //           Icon(Icons.edit, color: Color(0xFFE51F22))
                  //         ],
                  //       ),
                  //       SizedBox(height: 10),
                  //       Column(
                  //         children: [
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: [
                  //               Container(
                  //                 padding: EdgeInsets.all(10),
                  //                 decoration: BoxDecoration(
                  //                     color: Color(0xFFDBDBDB),
                  //                     borderRadius: BorderRadius.circular(20)),
                  //                 child: Text(
                  //                   "বড় প্রকল্প সমূহ",
                  //                   style: TextStyle(fontSize: 11),
                  //                 ),
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.all(10),
                  //                 decoration: BoxDecoration(
                  //                     color: Color(0xFFDBDBDB),
                  //                     borderRadius: BorderRadius.circular(20)),
                  //                 child: Text("জমি/প্রপার্টি",
                  //                     style: TextStyle(fontSize: 11)),
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.all(10),
                  //                 decoration: BoxDecoration(
                  //                     color: Color(0xFFDBDBDB),
                  //                     borderRadius: BorderRadius.circular(20)),
                  //                 child: Text("ব্যাংকিং ও বিনিয়োগ",
                  //                     style: TextStyle(fontSize: 11)),
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.all(10),
                  //                 decoration: BoxDecoration(
                  //                     color: Color(0xFFDBDBDB),
                  //                     borderRadius: BorderRadius.circular(20)),
                  //                 child: Text("প্রিন্সিপাল",
                  //                     style: TextStyle(fontSize: 11)),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(height: 10),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: [
                  //               Container(
                  //                 padding: EdgeInsets.all(10),
                  //                 decoration: BoxDecoration(
                  //                     color: Color(0xFFDBDBDB),
                  //                     borderRadius: BorderRadius.circular(20)),
                  //                 child: Text(
                  //                   "বিদেশী প্রিন্সিপাল",
                  //                   style: TextStyle(fontSize: 11),
                  //                 ),
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.all(10),
                  //                 decoration: BoxDecoration(
                  //                     color: Color(0xFFDBDBDB),
                  //                     borderRadius: BorderRadius.circular(20)),
                  //                 child: Text("মেশিনারিজ",
                  //                     style: TextStyle(fontSize: 11)),
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.all(10),
                  //                 decoration: BoxDecoration(
                  //                     color: Color(0xFFDBDBDB),
                  //                     borderRadius: BorderRadius.circular(20)),
                  //                 child: Text("সার্ভিসেস",
                  //                     style: TextStyle(fontSize: 11)),
                  //               ),
                  //             ],
                  //           )
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   height: size.height * 0.2,
                  //   width: double.infinity,
                  //   margin: EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //       color: Color(0xFFFEF3F3),
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child: Container(
                  //     margin: EdgeInsets.all(10),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "মেম্বারশিপ এরিয়া",
                  //           style: TextStyle(
                  //               fontSize: 18, fontWeight: FontWeight.bold),
                  //         ),
                  //         SizedBox(height: 5),
                  //         Text("বর্তমান মেম্বারশিপ : সিলভার "),
                  //         SizedBox(height: 5),
                  //         Text("মেম্বারশিপ শুরু হইয়েছে : December 22, 2021"),
                  //         SizedBox(height: 5),
                  //         Text("পরবর্তী পেমেন্ট তারিখ : February 20, 2022"),
                  //         SizedBox(height: 5),
                  //         InkWell(
                  //           onTap: () {
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                   builder: (context) =>
                  //                       Membershipiteam2page(),
                  //                 ));
                  //           },
                  //           child: Container(
                  //             padding: EdgeInsets.all(10),
                  //             decoration: BoxDecoration(
                  //                 color: Color(0xFFE94244),
                  //                 borderRadius: BorderRadius.circular(5)),
                  //             child: Text(
                  //               "মেম্বারশিপ আপগ্রেড করুন",
                  //               style: TextStyle(color: Colors.white),
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       InkWell(
                  //         onTap: () {
                  //           box.clear();
                  //           Navigator.pushAndRemoveUntil(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => LoginPage()),
                  //               (route) => false);
                  //         },
                  //         child: Container(
                  //           padding: EdgeInsets.all(10),
                  //           decoration: BoxDecoration(
                  //               color: Color(0xFFE94244),
                  //               borderRadius: BorderRadius.circular(5)),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: const [
                  //               Text(
                  //                 "লগ আউট",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //               SizedBox(width: 10),
                  //               Icon(
                  //                 Icons.arrow_forward,
                  //                 color: Colors.white,
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  membershiparea()
                ],
              ),
            ),
    );
  }

  List<int> animaleint = [];

  Widget categorybox() {
    final userprevilies = Provider.of<UserPreviliesProvider>(context);
    return Wrap(
      children: List.generate(animals.length, (index) {
        return InkWell(
          onTap: () {
            if (userprevilies.userPrevilies != null &&
                userprevilies.userPrevilies!.msg!.category !=
                    animaleint.length) {
              if (animaleint.contains(animals[index].id)) {
                setState(() {
                  animaleint.remove(animals[index].id);
                });
              } else {
                setState(() {
                  animaleint.add(animals[index].id!);
                });
              }
            } else {
              setState(() {
                animaleint.remove(animals[index].id);
              });
            }
          },
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: animaleint.contains(animals[index].id!)
                    ? Colors.indigo
                    : Colors.grey[200]),
            child: Text(
              animals[index].name!,
              style: TextStyle(
                  color: animaleint.contains(animals[index].id!)
                      ? Colors.white
                      : Colors.black,
                  fontFamily: 'Kalpurush'),
            ),
          ),
        );
      }),
    );
  }

  Widget membershiparea() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "মেম্বারশিপ এরিয়া",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Kalpurush'),
            ),
            SizedBox(height: 10),
            Text(
              "বর্তমান মেম্বারশিপ : সিলভার ",
              style: TextStyle(fontFamily: 'Kalpurush'),
            ),
            SizedBox(height: 5),
            Text(
              "মেম্বারশিপ শুরু হইয়েছে : December 22, 2021",
              style: TextStyle(fontFamily: 'Kalpurush'),
            ),
            SizedBox(height: 5),
            Text(
              "পরবর্তী পেমেন্ট তারিখ : February 20, 2022",
              style: TextStyle(fontFamily: 'Kalpurush'),
            ),
            SizedBox(height: 5),
            Divider(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(7),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Membershipiteam2page(),
                            ));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ApplyjobPage(
                        //         jobid: widget.data.jobId!,
                        //       ),
                        //     ));
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check,
                            size: 17,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "মেম্বারশিপ আপগ্রেড করুন",
                            style: TextStyle(fontFamily: 'Kalpurush'),
                          ),
                        ],
                      ),
                    )),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //       padding: EdgeInsets.all(5),
                //       child: Row(
                //         children: [
                //           Icon(
                //             Icons.share,
                //             size: 17,
                //           ),
                //           SizedBox(width: 5),
                //           Text("শেয়ার"),
                //         ],
                //       )),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Animal {
  final int? id;
  final String? name;

  Animal({
    this.id,
    this.name,
  });
}
