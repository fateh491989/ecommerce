import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
           appBar: AppBar(
             elevation: 0.0,
             centerTitle: true,
             title: Text("My Orders"),
             backgroundColor: Colors.blueGrey,
           ),
          body: StreamBuilder<QuerySnapshot>(
              stream: EcommerceApp.firestore
                  .collection(EcommerceApp.collectionUser)
                  .document(EcommerceApp.sharedPreferences
                  .getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.collectionOrders).snapshots(),
              builder: (_, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (_, index) {
                          return FutureBuilder<QuerySnapshot>(
                              future: Firestore.instance
                                  .collection('books')
                                  .where('isbn',
                                      whereIn: snapshot.data.documents[index]
                                          .data[EcommerceApp.productID])
                                  .getDocuments(),
                              builder: (_, snap) {
                                return snap.hasData?OrderCard(
                                  itemCount: snap.data.documents.length,
                                  data: snap.data.documents,
                                  orderID: snapshot.data.documents[index].documentID
                                ): Center(child: LoadingWidget());
                              });
                        })
                    : Center(child: LoadingWidget());
              })),
    );
  }
}
