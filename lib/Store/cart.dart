import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';
import 'Config/config.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text("Cart"),
            backgroundColor: Colors.blueGrey,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (_) => CartPage());
                    Navigator.push(context, route);
                  }),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('products').where('id',whereIn: EcommerceApp.sharedPreferences
                  .getStringList(
                EcommerceApp.userCartList,
              )).snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: CircularProgressIndicator(),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ListTile(
                                trailing: IconButton(
                                    icon: Icon(Icons.remove_shopping_cart),
                                    onPressed: () => _removeItemInCart(snapshot
                                        .data.documents[index].data['id'])),
                                title: Text(snapshot
                                    .data.documents[index].data['name']));
                          },
                          childCount: snapshot.hasData
                              ? snapshot.data.documents.length
                              : 0,
                        ),
                      );
              })
        ],
      ),
    );
  }

  _removeItemInCart(String productID) {
      List temp = EcommerceApp.sharedPreferences
        .getStringList(
          EcommerceApp.userCartList,
        );
        temp.remove(productID);
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList: temp
    }).then((_) {
      Fluttertoast.showToast(msg: 'Item Removed Succesfully');
      EcommerceApp.sharedPreferences.setStringList(
          EcommerceApp.userCartList,temp);
      setState(() {

      });
    });
  }
}
