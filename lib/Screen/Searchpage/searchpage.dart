// import 'package:flutter/material.dart';
// import 'package:jobs_app/Model/Search_Job/searchjob.dart';
// import 'package:jobs_app/Provider/Search/search.dart';
// import 'package:jobs_app/Provider/home.dart';
// import 'package:provider/provider.dart';

// class Searchpage extends StatefulWidget {
//   const Searchpage({Key? key}) : super(key: key);

//   @override
//   _SearchpageState createState() => _SearchpageState();
// }

// class _SearchpageState extends State<Searchpage> {
//   bool loading = false;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final search = Provider.of<Searchprovider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         flexibleSpace: ClipRRect(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(10),
//           ),
//           child: const Image(
//             image: AssetImage(
//               'images/Top Bar illustration Solid.png',
//             ),
//             fit: BoxFit.cover,
//           ),
//         ),
//         backgroundColor: Color(0xFFE51D20),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(10),
//           ),
//         ),
//         title: const Text(
//           "মোঃ হাসান ইসলাম",
//           style: TextStyle(fontSize: 14),
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(30.0),
//           child: Container(
//             child: Column(
//               children: [
//                 const Text(
//                   "আপনার লিংক সার্চ করুন",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Text(
//                   "যেকোনো ধরণের কাজ প্রজেক্ট ব্যবসা অথবা সাপ্লাই এর কাজের লিংক এবং কানেকশন পান যখন তখন যেখানে সেখানে",
//                   style: TextStyle(
//                       fontSize: 8, color: Colors.white.withOpacity(0.7)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         centerTitle: true,
//         // leading: Column(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: [
//         //     Text("কানেক্ট"),
//         //   ],
//         // ),
//         actions: [
//           // IconButton(onPressed: () {}, icon: Icon(Icons.search)),
//           IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Container(
//           //   alignment: Alignment.center,
//           //   padding: const EdgeInsets.only(bottom: 5),
//           //   width: size.width,
//           //   decoration: const BoxDecoration(
//           //     borderRadius: BorderRadius.only(
//           //         bottomLeft: Radius.circular(10),
//           //         bottomRight: Radius.circular(10)),
//           //     color: Color(0xFFE51D20),
//           //   ),
//           //   child: Column(
//           //     children: [
//           //       const Text(
//           //         "আপনার লিংক সার্চ করুন",
//           //         style: TextStyle(color: Colors.white),
//           //       ),
//           //       Text(
//           //         "যেকোনো ধরণের কাজ প্রজেক্ট ব্যবসা অথবা সাপ্লাই এর কাজের লিংক এবং কানেকশন পান যখন তখন যেখানে সেখানে",
//           //         style: TextStyle(
//           //             fontSize: 8, color: Colors.white.withOpacity(0.7)),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           searchpage(),
//           search.searchJob == null
//               ? Text(
//                   "Search Job",
//                   style: TextStyle(color: Colors.black.withOpacity(0.7)),
//                 )
//               : Flexible(child: alllinkservice()),
//         ],
//       ),
//     );
//   }

//   Widget searchpage() {
//     final search = Provider.of<Searchprovider>(context);
//     return Container(
//       margin: EdgeInsets.all(20),
//       child: TextFormField(
//         onChanged: (value) {
//           if (value.isNotEmpty) {
//             search
//                 .getsearchjob(keyword: value, context: context)
//                 .then((value) {});
//           }
//         },
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//             hintText: "সার্চ করুন",
//             border: InputBorder.none,
//             filled: true,
//             fillColor: Colors.grey[300]),
//       ),
//     );
//   }

//   Widget alllinkservice() {
//     final search = Provider.of<Searchprovider>(context);
//     return search.searchJob!.msg!.isEmpty
//         ? Center(
//             child: Text("No Job Found"),
//           )
//         : ListView.builder(
//             itemCount: search.searchJob!.msg!.length,
//             itemBuilder: (context, index) {
//               var data = search.searchJob!.msg![index];
//               return SeachJobPage(
//                 data: data,
//               );
//             },
//           );
//   }
// }

// class DescriptionTextWidget extends StatefulWidget {
//   final String? text;

//   DescriptionTextWidget({@required this.text});

//   @override
//   _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
// }

// class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
//   String? firstHalf;
//   String? secondHalf;

//   bool flag = true;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.text!.length > 60) {
//       firstHalf = widget.text!.substring(0, 60);
//       secondHalf = widget.text!.substring(60, widget.text!.length);
//     } else {
//       firstHalf = widget.text;
//       secondHalf = "";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: secondHalf!.isEmpty
//           ? Text(firstHalf!)
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(flag ? (firstHalf!) : (firstHalf! + secondHalf!)),
//                 InkWell(
//                   child: Container(
//                     margin: EdgeInsets.only(right: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: <Widget>[
//                         Text(
//                           flag ? ".....show more" : "show less",
//                           style: TextStyle(
//                               color: Color(0xFFE51D20).withOpacity(0.8)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   onTap: () {
//                     setState(() {
//                       flag = !flag;
//                     });
//                   },
//                 ),
//               ],
//             ),
//     );
//   }
// }

// class SeachJobPage extends StatefulWidget {
//   final Msg data;
//   const SeachJobPage({Key? key, required this.data}) : super(key: key);

//   @override
//   _SeachJobPageState createState() => _SeachJobPageState();
// }

// class _SeachJobPageState extends State<SeachJobPage> {
//   String categoryname = "";

//   void categorynamefind() {
//     final homeprovider = Provider.of<HomeProvider>(context, listen: false);
//     for (var i = 0; i < homeprovider.categorylist!.msg!.length; i++) {
//       if (widget.data.category == homeprovider.categorylist!.msg![i].catId) {
//         setState(() {
//           categoryname = homeprovider.categorylist!.msg![i].catName!;
//         });
//       }
//     }
//   }

//   @override
//   void initState() {
//     categorynamefind();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       child: Material(
//         elevation: 1,
//         child: Container(
//           color: Color(0xFFF8C2C2),
//           padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.data.jobTitle!,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               SizedBox(height: 10),
//               Text("কানেক্ট আইডি: ${widget.data.jobId}"),
//               Text(categoryname),
//               SizedBox(height: 10),
//               DescriptionTextWidget(
//                 text: widget.data.description,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
