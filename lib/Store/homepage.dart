
import '../STORE/product_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Config/config.dart';

class StoreHomePage extends StatefulWidget {
  @override
  _StoreHomePageState createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
         centerTitle: true,
         title: Text("Book Store"),
         backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,), onPressed: null),
        ],
      ),
      drawer: Drawer(),

      body:
//      CustomScrollView(
//        reverse: true,
//        scrollDirection: Axis.vertical,
//
//        slivers: <Widget>[

        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
               Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 80.0,
                  color: Colors.blueGrey,
                  child:InkWell(
                      //onTap: (){Navigator.push(context, MaterialPageRoute(builder: (builder)=>signin()));},
                    child: Container(
                    width: MediaQuery.of(context).size.width-40.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                 child: Row(
                   children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.only(left : 8.0),
                       child: Icon(Icons.search,color: Colors.blueGrey,),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left :8.0),
                       child: Text("Search here"),
                     )
                   ],
                 ),
                  )
                  )
              ),
              // Page Veiwer

              Flexible(
                child: PageView.builder(
                  itemCount: 5,
                  itemBuilder: (context, position){
                    return buildPageItem(context, position);
                  },
                ),
              ),
              Container(
                color: Colors.white,
                height: 120.0,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, top: 8.0),
                      child: InkWell(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: 90.0,
                              width: MediaQuery.of(context).size.width/4-10.0,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  shape: BoxShape.circle
                              ),
                            ),
                            Text("Novel")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,  top: 8.0),
                      child: InkWell(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: 90.0,
                              width: MediaQuery.of(context).size.width/4-10.0,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  shape: BoxShape.circle
                              ),
                            ),
                            Text("TextBook")
                          ],                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,  top: 8.0),
                      child: InkWell(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: 90.0,
                              width: MediaQuery.of(context).size.width/4-10.0,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  shape: BoxShape.circle
                              ),
                            ),
                            Text("Novel")
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,  top: 8.0),
                      child: InkWell(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: 90.0,
                              width: MediaQuery.of(context).size.width/4-10.0,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  shape: BoxShape.circle
                              ),
                            ),
                            Text("Novel")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection(EcommerceApp.collectionAllBooks).snapshots(),
                      builder: ( context,  snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 1.0,
                                mainAxisSpacing: 1.0,
                                childAspectRatio: MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height )*1.1,
                                crossAxisCount: 2),
                            itemCount: 22,
                            //snapshot.data.documents.length,
                            padding: EdgeInsets.all(2.0),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>ProductPage()));
                                },
                                child: Container(

                                  color: Colors.white,
                                  child: Column(
                                   children: <Widget>[
//                                     Image.network(snapshot.data.documents[index].data["url"],
//                                       width: MediaQuery.of(context).size.width/2-40.0,
//                                       height: 180.0,
//                                       fit: BoxFit.fill,
//                                     ),
                                     Text("Power"),
                                     Text("Power"),
                                     Text("Power"),
                                     Text("Power"),
                                     Text("By Fateh Singh"),
                                     Row(
                                       children: <Widget>[
                                         Text("MRP- 47894758")
                                       ],
                                     )
                                   ],
                                  ),
                                  padding: EdgeInsets.all(20.0),
                                ),
                              );
                            },
                          );
                        }
                        else {
                          return CircularProgressIndicator();
                        }
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
//        ],
//    ),
    );
  }

  Widget buildPageItem(BuildContext context, int index){
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(EcommerceApp.collectionAllBooks).snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
          return Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child:
            Image.network(snapshot.data.documents[index].data["url"],
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            //Text("${snapshot.data.documents[index].data["url"]} "),
          );}
          else {
            return LinearProgressIndicator();
          }
        });
  }

}


