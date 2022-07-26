import 'package:flutter/material.dart';
import 'package:jobs_app/Provider/Job_Apply/applicationListProvider.dart';
import 'package:jobs_app/Provider/Job_Apply/job_apply.dart';
import 'package:jobs_app/Screen/Chat/chatdetails.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../../Const_value/apilink.dart';
import '../../Provider/UserProfile/UserProfile.dart';
import '../Linkscreen/mylinkscreen.dart';
import '../VideoPlay/videoplayer.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import '../create_Job/audioplay.dart';
import '../../Model/ApplicationList/AppliedList.dart';
class ApplicationList extends StatefulWidget {
  final String? details;
  final String? id, title, jobid;
  const ApplicationList(
      {Key? key, required this.details, required this.id, required this.title,required this.jobid})
      : super(key: key);

  @override
  State<ApplicationList> createState() => _ApplicationListState();
}

class _ApplicationListState extends State<ApplicationList> {

  ApplicationList? applicationList;
  bool loading = true;
  final player = AudioPlay();
  JobApplyprovider jobApplyprovider = JobApplyprovider();
  Future loaddata() async {
    print(widget.id! +"sdwdqafs");
   await Provider.of<JobApplyprovider>(context, listen: false).getapplicationlist(widget.jobid!);
  }
  @override
  void initState() {



jobApplyprovider.getapplicationlist(widget.jobid!);
    player.playaudioinit();
if(jobApplyprovider.map["msg"]=="No application found!"){
  setState((){
    loading = false;
  });
}
    print(widget.id! +"widgetId");
    print(widget.jobid! +"widgetId");
    loaddata().then((value) {
      setState((){
        loading = false;
      });
      if(jobApplyprovider.map["msg"]=="No application found!"){
        setState((){
          loading = false;
        });
      }


    });
if(jobApplyprovider.map["msg"]=="No application found!"){
  setState((){
    loading = false;
  });
}
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // // context.read<JobApplyprovider>().fetchData(widget.id!).then((value){
    // //   setState(() {
    // //
    // //     loading = false;
    // //   });
    // // });
    context.read<JobApplyprovider>().getapplicationlist(widget.jobid!);
    //context.read<UserProfileProvider>().fetchData(widget.id!);

    // Provider.of<UserProfileProvider>(context).fetchData(widget.id!);
    final job = Provider.of<JobApplyprovider>(context);
    final user = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(

        title: const Text("Application",
            style: TextStyle(fontSize: 16, fontFamily: 'Kalpurush')),
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        backgroundColor: const Color(0xFFE51D20),
        centerTitle: true,
        leadingWidth: 70,
      ),
      body:
      job.map["msg"]=="No application found!"?const Center(child: Text("No Application Found"),):
      loading? const Center(child: CircularProgressIndicator()):



      job.applicationList == null
          ?  const Center(
        child: Text("No Data Found"),
      ): job.applicationList!.error ==1?
          Text(job.applicationList!.msg.toString())

          :job.applicationList!.msg!.isNotEmpty? ListView.builder(
          itemCount: job.applicationList!.msg!.length,
          itemBuilder: ((context, index) {


            var data = job.applicationList!.msg![index];
            user.fetchData(data.userId!);
        //   var userData = user.userProfileModel!.msg!.userData;
            return

             user.error && user.map["msg"]!=null?
              Card(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Applicant Name: ${user.map["msg"]["user_data"]["full_name"]}"),
                      Text("Applicant Phone: ${user.map["msg"]["user_data"]["phone"]}"),
                      //Text("Applicant Phone: ${user.userProfileModel!.msg!.userData!.phone}"),
                      Text("Time: ${data.time!}"),
                      Text("Price: ${data.price}"),
                      Text("Status: ${data.status}"),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ChatdetailsPage(
                                  name: user.map["msg"]["user_data"]["full_name"],
                                  applyid: data.applyId.toString(),
                                  jobid: data.jobId.toString(),
                                  recvid: data.userId.toString(),
                                  senderid: data.ownerId.toString(), titile: widget.title!,
                                ))));
                      },
                      icon: const Icon(Icons.messenger))
                ],
              ),
            ):  Container(
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
          })): const Text("No Application Found")

    );
  }
}
