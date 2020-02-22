import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Store/cart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Store/Config/config.dart';
import 'Store/product_page.dart';
import 'main.dart';

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text("Book Store"),
            backgroundColor: Colors.blueGrey,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Route route = MaterialPageRoute(builder: (_)=>CartPage());
                    Navigator.push(context, route);
                  }),
            ],
          ),
          SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('products').snapshots(),
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
                                    icon: Icon(Icons.add_shopping_cart),
                                    onPressed: () => _checkItemInCart(snapshot
                                        .data.documents[index % 2].data['id'])),
                                title: Text(snapshot
                                    .data.documents[index % 2].data['name']));
                          },
                          childCount: snapshot.hasData
                              ? snapshot.data.documents.length * 10
                              : 0,
                        ),
                      );
              })
        ],
      ),
    );
  }

  void _checkItemInCart(String productID) {
    print(productID);
    ///print(cartItems);
    EcommerceApp.sharedPreferences
            .getStringList(
              EcommerceApp.userCartList,
            )
            .contains(productID)
        ? Fluttertoast.showToast(msg: 'Product is already in cat')
        : _addToCart(productID);
  }

  _addToCart(String productID) {
    List temp = EcommerceApp.sharedPreferences
        .getStringList(
      EcommerceApp.userCartList,
    );
    temp.add(productID);
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({EcommerceApp.userCartList: temp
    }).then((_) {
      Fluttertoast.showToast(msg: 'Item Added Succesfully');
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, temp
      );
    });
  }
}
QuerySnapshot snapshot;

class Data {
  data() async {
    snapshot = await Firestore.instance
        .collection(EcommerceApp.collectionAllBooks)
        .getDocuments();
  }
}

class SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          color: Colors.blueGrey,
          child: InkWell(
              //onTap: (){Navigator.push(context, MaterialPageRoute(builder: (builder)=>signin()));},
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Search here"),
                )
              ],
            ),
          )));

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
