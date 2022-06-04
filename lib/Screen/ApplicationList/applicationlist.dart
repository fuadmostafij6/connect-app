import 'package:flutter/material.dart';
import 'package:jobs_app/Provider/Job_Apply/job_apply.dart';
import 'package:jobs_app/Screen/Chat/chatdetails.dart';
import 'package:provider/provider.dart';

class ApplicationList extends StatefulWidget {
  const ApplicationList({Key? key}) : super(key: key);

  @override
  State<ApplicationList> createState() => _ApplicationListState();
}

class _ApplicationListState extends State<ApplicationList> {
  bool loading = true;

  @override
  void initState() {
    Provider.of<JobApplyprovider>(context, listen: false)
        .getapplicationlist()
        .then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final job = Provider.of<JobApplyprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Application",
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
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: job.applicationList!.msg!.length,
              itemBuilder: ((context, index) {
                var data = job.applicationList!.msg![index];
                return Card(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Time: ${data.time!}"),
                          Text("Doc: ${data.doc}"),
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
                                    builder: ((context) => ChatdetailsPage(applyid: data.applyId.toString(),jobid: data.jobId.toString(),recvid: data.userId.toString(),senderid: data.ownerId.toString(),))));
                          },
                          icon: Icon(Icons.messenger))
                    ],
                  ),
                );
              })),
    );
  }
}
