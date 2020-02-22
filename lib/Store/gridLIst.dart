import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("baby").snapshots(),
            builder: ( context,  snapshot) {
              if (snapshot.hasData) {

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      crossAxisCount: 2),
                  itemCount: snapshot.data.documents.length,
                  padding: EdgeInsets.all(2.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Color.fromRGBO(257, 257, 257, 1.0),
                      child: Text("${snapshot.data.documents[index].data["chapterID"]}", style: TextStyle(
                          color: Colors.white
                      ),),
                      padding: EdgeInsets.all(20.0),
                    );
                  },
                );
              }
              else {
                return CircularProgressIndicator();
              }
            }
        )
    );
  }
}
