import 'package:flutter/material.dart';
import 'package:jobs_app/Provider/Search/search.dart';
import 'package:jobs_app/Screen/Categoryjob/categoryjob.dart';
import 'package:provider/provider.dart';

class Categorysearchpage extends StatefulWidget {
  const Categorysearchpage({Key? key}) : super(key: key);

  @override
  _CategorysearchpageState createState() => _CategorysearchpageState();
}

class _CategorysearchpageState extends State<Categorysearchpage> {
  @override
  Widget build(BuildContext context) {
    final search = Provider.of<Searchprovider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      child: search.searchcategory == null
          ? Container()
          : GridView.builder(
              itemCount: search.searchcategory!.msg!.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                var data = search.searchcategory!.msg![index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryjobPage(
                              categoryid: data.catId!,
                              categoryname: data.catName!,
                            ),
                          ));
                    },
                    child: Container(
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                              colors: [Color(0xFFE51D20), Color(0xFFE51D20)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.category,
                                size: 30,
                                color: Colors.white,
                              )),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              data.catName!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Kalpurush'),
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
