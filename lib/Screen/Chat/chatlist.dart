import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jobs_app/Model/chatlist.dart';
import 'package:jobs_app/Screen/Menu/menu.dart';
import 'package:jobs_app/Screen/Searchpage/mainsearchpage.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../../Model/MessageBox/messageboxlist.dart';
import '../../Model/Messagelist/contactMessageList.dart';
import '../../Provider/Jobdetails/jobdetails.dart';
import '../../Provider/Message/contactMessageProvuder.dart';
import '../../Provider/Message/message.dart';
import 'chatdetails.dart';

class ChatListpage extends StatefulWidget {
  const ChatListpage({Key? key}) : super(key: key);

  @override
  _ChatListpageState createState() => _ChatListpageState();
}

class _ChatListpageState extends State<ChatListpage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  ContactMessageList? contactMessageList;
  JobDetailsProvider jobDetailsProvider = JobDetailsProvider();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mess = Provider.of<ContactMessageProvider>(context);
    var box = Hive.box('login');

    return Scaffold(
        key: _key,
        endDrawer: const DrawerPage(),
        appBar: AppBar(
          title: const Text('বার্তা সমূহ',
              style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush')),
          elevation: 0,
          backgroundColor: const Color(0xFFE51D20),
          flexibleSpace: const Image(
            image: AssetImage(
              'images/Top Bar illustration Solid.png',
            ),
            fit: BoxFit.cover,
          ),
          centerTitle: true,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
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
                child: const Icon(Icons.search)),

            const SizedBox(width: 5),
            InkWell(
                onTap: () {
                  _key.currentState!.openEndDrawer();
                },
                child: const Icon(Icons.menu)),
            const SizedBox(width: 10),
            // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          ],
        ),
        body: StreamBuilder<ContactMessageList?>(
          stream: mess.streammessage(const Duration(seconds: 1)),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;

              return snapshot.data == null
                  ? const Center(
                      child: Text("No Message"),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.msg!.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.msg![index];
                        print(data.jobId);
                        jobDetailsProvider.getjobdetails(data.jobId!);

                        return jobDetailsProvider.jobDetails != null
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                color: const Color(0xFFF4F4F4),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatdetailsPage(
                                            name: data.name,
                                            applyid: data.applyId!,
                                            jobid: data.jobId!,
                                            recvid: data.applyId!,
                                            senderid: data.senderId!,
                                            titile: jobDetailsProvider
                                                .jobDetails!.msg!.jobTitle!,
                                          ),
                                        ));
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(data.photo!),
                                      ),
                                      Flexible(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    data.name!,
                                                    style: const TextStyle(
                                                        color: const Color(
                                                            0xFF000000),
                                                        fontSize: 15,
                                                        fontFamily:
                                                            'Kalpurush'),
                                                  ),
                                                  const Spacer(),
                                                ],
                                              ),
                                              Text(
                                                data.msg!,
                                                style: const TextStyle(
                                                    color: Color(0xFF919195),
                                                    fontFamily: 'Kalpurush'),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                            : Container(
                          margin:const EdgeInsets.only(bottom: 10.0),
                              child: SkeletonItem(
                                  child: Column(

                                      children: [
                                  Row(
                                    children: [
                                      const SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                            shape: BoxShape.circle,
                                            width: 50,
                                            height: 50),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: SkeletonParagraph(
                                          style: SkeletonParagraphStyle(
                                              lines: 3,
                                              spacing: 6,
                                              lineStyle: SkeletonLineStyle(
                                                randomLength: true,
                                                height: 10,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                minLength: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    6,
                                                maxLength: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ])),
                            );
                      },
                    );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("No Massage to show"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ));
  }
}
