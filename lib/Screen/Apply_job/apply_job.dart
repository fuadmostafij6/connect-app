// import 'dart:io';

// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:jobs_app/Provider/Job_Apply/job_apply.dart';
// import 'package:jobs_app/Screen/Apply_job/custompaint.dart';
// import 'package:jobs_app/Screen/Menu/menu.dart';
// import 'package:jobs_app/Screen/Searchpage/searchpage.dart';
// import 'package:jobs_app/Screen/Searchpage/Tab/searchpage2.dart';
// import 'package:provider/provider.dart';

// class ApplyjobPage extends StatefulWidget {
//   final String jobid;
//   const ApplyjobPage({Key? key, required this.jobid}) : super(key: key);

//   @override
//   _ApplyjobPageState createState() => _ApplyjobPageState();
// }

// class _ApplyjobPageState extends State<ApplyjobPage> {
//   String? filename;

//   String? jobid, userid, time, note;
//   final GlobalKey<ScaffoldState> _key = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     final jobapply = Provider.of<JobApplyprovider>(context);
//     var box = Hive.box('login');
//     return Scaffold(
//       // key: _key,
//       // endDrawer: DrawerPage(),
//       appBar: AppBar(
//         title: Text('প্রস্তাবনা',
//             style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush')),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         toolbarHeight: 150,
//         // backgroundColor: Color(0xFFE51D20),
//         // flexibleSpace: const ClipRRect(
//         //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
//         //   child: Image(
//         //     image: AssetImage(
//         //       'images/Top Bar illustration Solid.png',
//         //     ),
//         //     fit: BoxFit.cover,
//         //   ),
//         // ),
//         flexibleSpace: ClipPath(
//           clipper: Customshape(),
//           child: Container(
//             height: 250,
//             width: MediaQuery.of(context).size.width,
//             color: Color(0xFFE51D20),
//             child: Center(
//                 child: Text(
//               "Subscribe to Proto Coders Point",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             )),
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back)),
//         actions: [
//           // InkWell(
//           //     onTap: () {
//           //       Navigator.push(
//           //           context,
//           //           MaterialPageRoute(
//           //             builder: (context) => const Searchpage2(),
//           //           ));
//           //     },
//           //     child: Icon(Icons.search)),
//           // SizedBox(width: 5),
//           // InkWell(
//           //     onTap: () {
//           //       _key.currentState!.openEndDrawer();
//           //     },
//           //     child: Icon(Icons.menu)),
//           // SizedBox(width: 10),
//         ],
//       ),

//       body: Card(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),
//             Container(
//                 margin: EdgeInsets.only(left: 10),
//                 child: Text(
//                   "নিচের তথ্য গুলো পূরণ করুন",
//                   style: TextStyle(fontSize: 20, fontFamily: 'Kalpurush'),
//                 )),
//             SizedBox(height: 10),
//             dropdowntext(),
//             SizedBox(height: 10),
//             filepicker(),
//             SizedBox(height: 10),
//             textform(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(bottom: 5),
//                   decoration: BoxDecoration(
//                       color: Color(0xFFE51D20),
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () {
//                         jobapply.jobapply(
//                             jobid: widget.jobid,
//                             note: note,
//                             time: time,
//                             context: context,
//                             userid: box.get('userid'));
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         width: MediaQuery.of(context).size.width * 0.6,
//                         height: MediaQuery.of(context).size.height * 0.06,
//                         child: Text(
//                           "প্রস্তাবনা সম্পুন্ন করুন",
//                           style: TextStyle(
//                               color: Colors.white, fontFamily: 'Kalpurush'),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // MaterialButton(
//                 //   color: Color(0xFFE51D20),

//                 //   onPressed: () {
//                 //     jobapply.jobapply(
//                 //         jobid: widget.jobid,
//                 //         note: note,
//                 //         time: time,
//                 //         context: context,
//                 //         userid: box.get('userid'));
//                 //   },
//                 //   child: Text(
//                 //     "প্রস্তাবনা সম্পুন্ন করুন",
//                 //     style:
//                 //         TextStyle(color: Colors.white, fontFamily: 'Kalpurush'),
//                 //   ),
//                 // ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget dropdowntext() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//             padding: EdgeInsets.all(10),
//             child: Text(
//               "(০১) কাজটি করতে কেমন সময় লাগবে?",
//               style: TextStyle(fontFamily: 'Kalpurush'),
//             )),
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 10),
//           child: DropdownSearch<String>(
//             dropdownBuilder: (context, selectedItem) {
//               return Container(
//                 child: Text(
//                   selectedItem!,
//                   style: TextStyle(fontFamily: 'Kalpurush', fontSize: 18),
//                 ),
//               );
//             },
//             popupItemBuilder: (context, item, isSelected) {
//               return Container(
//                 padding: EdgeInsets.all(10),
//                 child: Text(
//                   item,
//                   style: TextStyle(fontFamily: 'Kalpurush'),
//                 ),
//               );
//             },
//             mode: Mode.MENU,
//             items: [
//               "অনির্ধারিত",
//               "২ দিনের মত",
//               "৪ দিনের মত",
//               "১ সপ্তাহ",
//               '২ সপ্তাহ',
//               '৩ সপ্তাহ',
//               '১ মাস',
//               '2 মাস'
//             ],
//             dropdownSearchDecoration: InputDecoration(
//               errorStyle: TextStyle(height: 0),
//               hintStyle: TextStyle(fontFamily: 'Kalpurush'),
//               contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//             ),
//             hint: "অনির্ধারিত",
//             selectedItem: "অনির্ধারিত",
//             onChanged: (value) {
//               setState(() {
//                 time = value;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget filepicker() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//             margin: EdgeInsets.only(left: 10, top: 4),
//             child: Text(
//               "(০২) ফাইল যুক্ত করুন (ঐচ্ছিক)",
//               style: TextStyle(fontFamily: 'Kalpurush'),
//             )),
//         Container(
//           margin: EdgeInsets.all(10),
//           padding: EdgeInsets.all(5),
//           decoration: BoxDecoration(),
//           child: Row(
//             children: [
//               InkWell(
//                 onTap: () async {
//                   FilePickerResult? result =
//                       await FilePicker.platform.pickFiles();

//                   if (result != null) {
//                     File file = File(result.files.single.path!);
//                     setState(() {
//                       filename = result.files.single.name;
//                     });
//                   } else {
//                     // User canceled the picker
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
//                   child: Text("Choose File",
//                       style: TextStyle(
//                           color: Colors.black, fontFamily: 'Kalpurush')),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Text(
//                 filename ?? "No File Chosen",
//                 style: TextStyle(fontFamily: 'Kalpurush'),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget textform() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//             child: Text(
//               "(০৩) নোট (ঐচ্ছিক)",
//               style: TextStyle(fontFamily: 'Kalpurush'),
//             )),
//         Container(
//           margin: EdgeInsets.all(10),
//           child: TextFormField(
//             onChanged: (value) {
//               setState(() {
//                 note = value;
//               });
//             },
//             maxLines: 5,
//             decoration: InputDecoration(
//               errorStyle: TextStyle(height: 0),
//               hintStyle: TextStyle(fontFamily: 'Kalpurush'),
//               contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
