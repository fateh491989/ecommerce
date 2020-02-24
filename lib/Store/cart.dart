import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/modals/book.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecommerce/storehome.dart';
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
              stream: Firestore.instance.collection('books').where(
                  'isbn', whereIn: EcommerceApp.sharedPreferences
                  .getStringList(
                EcommerceApp.userCartList,
              )).snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
                    : snapshot.data.documents.length == 0 ? startBuildingCart():SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      BookModel model = BookModel.fromJson(
                          snapshot.data.documents[index].data);
                      return sourceInfo(model, context,
                          removeCartFunction: ()=> removeItemInCart(model.isbn));
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
   // TODO Make design better
   startBuildingCart(){
    return SliverToBoxAdapter(
      child: Card(
        color: Colors.red.withOpacity(0.5),
        child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.insert_emoticon,color: Colors.white),
                Text('You dont have any product in cart' ),
                Text('Start building your cart now!!'),
              ],
            )),
      ),
    );

  }

  removeItemInCart(String productID) {
    print('Someone called me');
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
          EcommerceApp.userCartList, temp);
      setState(() {

      });
    });
  }

}