import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobs_app/Provider/home.dart';
import 'package:provider/provider.dart';

class Allcategorypage extends StatefulWidget {
  const Allcategorypage({Key? key}) : super(key: key);

  @override
  _AllcategorypageState createState() => _AllcategorypageState();
}

class _AllcategorypageState extends State<Allcategorypage> {
  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Category'),
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage(
            'images/Top Bar illustration Solid.png',
          ),
          fit: BoxFit.cover,
        ),
        backgroundColor: Color(0xFFE51D20),

        centerTitle: true,
        // leading: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text("কানেক্ট"),
        //   ],
        // ),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text("সব ক্যাটাগরি",
                        style: TextStyle(
                            fontFamily: 'Kalpurush',
                            color: Colors.black.withOpacity(0.8))),
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
              Divider(height: 0),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: homeprovider.categorylist!.msg!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  'images/svg/compact-disc-solid.svg',
                                  height: 40,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  homeprovider
                                      .categorylist!.msg![index].catName!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'Kalpurush',
                                      color: Colors.black.withOpacity(0.9)))
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
