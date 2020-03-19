
import 'package:ecommerce/modals/book.dart';
import 'package:ecommerce/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Widgets/customAppBar.dart';

class SearchService {

  searchByName(String searchField) {
    print(searchField);
    return Firestore.instance
        .collection('books')
        .where('title',
        isGreaterThanOrEqualTo: searchField)
        .getDocuments();
  }
}

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => new _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  Future<QuerySnapshot> documnetList;
   Future initSearch(String query)async{
     String capitalizedValue ;
     if(query.length>1){
       capitalizedValue =
           query.substring(0, 1).toUpperCase() + query.substring(1);
     }
     else if(query.length>0){
       capitalizedValue =
           query.substring(0, 1).toUpperCase();
     }

     documnetList =  Firestore.instance.collection('books').where('title',isGreaterThanOrEqualTo: capitalizedValue).getDocuments();
   // print('documents: ${(await documnetList).documents[0].data['title']}');
    setState(() {

    });
  }
  Widget searchWidget(){
     return Container(
         alignment: Alignment.center,
         width: MediaQuery.of(context).size.width,
         height: 80.0,
         color: Colors.blueGrey,
         child: Container(
           width: MediaQuery.of(context).size.width - 40.0,
           height: 50.0,
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(5.0),
           ),
           child: Row(
             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.only(left: 8.0),
                 child: Icon(
                   Icons.search,
                   color: Colors.blueGrey,
                 ),
               ),
               Flexible(
                 child: Padding(
                   padding: const EdgeInsets.only(left: 8.0),
                   child: TextField(
                     onChanged: (val) {
                       //initiateSearch(val);
                       initSearch(val);
                     },
                     decoration: InputDecoration.collapsed(hintText: 'Search'),
                   ),
                 ),
               )
             ],
           ),
         ));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
          appBar:
          MyAppBar(
            bottom: PreferredSize(child: searchWidget(), preferredSize: Size(56,56)),
          ),
//        AppBar(
//          title: Text('Book Store'),
//          //bottom: PreferredSize(child: searchWidget(), preferredSize: Size(80,80)),
//          //flexibleSpace: SearchWidget(),
//        ),

          body: FutureBuilder<QuerySnapshot>(
            future: documnetList,
            builder: (context, snapshot) {

              return snapshot.hasData?ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context,index){
                    BookModel model = BookModel.fromJson(snapshot.data.documents[index].data);
                return sourceInfo(model,context);
              }):Text('No data');
            }
          )),
    );
  }
}

Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
          child: Center(
              child: Text(data['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              )
          )
      )
  );
}