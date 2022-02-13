import 'package:flutter/material.dart';
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
        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
        child: GridView.builder(
          itemCount: homeprovider.categorylist!.msg!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            'images/post.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          homeprovider.categorylist!.msg![index].catName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
