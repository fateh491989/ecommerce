import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Config/config.dart';
import 'package:ecommerce/Delievery/address.dart';
import 'package:ecommerce/Widgets/customAppBar.dart';
import 'package:ecommerce/Widgets/loadingWidget.dart';
import 'package:ecommerce/modals/book.dart';
import 'package:ecommerce/notifiers/cartitemcounter.dart';
import 'package:ecommerce/notifiers/totalMoney.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecommerce/Store/storehome.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount;

  @override
  void initState() {
    super.initState();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(EcommerceApp.sharedPreferences.getStringList(
            EcommerceApp.userCartList).length==1){
            Fluttertoast.showToast(msg: 'No item in cart');
          }
          else{
            Route route = MaterialPageRoute(builder: (_) => Address(totalAmount: totalAmount.toDouble(),));
            Navigator.push(context, route);
          }
        },
        label: Text('Check Out'),
        backgroundColor: Colors.deepPurple,
        icon: Icon(Icons.navigate_next),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: MyAppBar(),
          ),
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount,CartItemCounter>(builder: (context, amountProvider,cartProvider, _) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: cartProvider.count==0?Container():Text(
                    'Total price: ${amountProvider.totalAmount.toString()}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('books')
                  .where('isbn',
                      whereIn: EcommerceApp.sharedPreferences.getStringList(
                        EcommerceApp.userCartList,
                      ))
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(child: LoadingWidget()),
                      )
                    : snapshot.data.documents.length == 0
                        ? startBuildingCart()
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                BookModel model = BookModel.fromJson(
                                    snapshot.data.documents[index].data);
                                if(index==0)
                                  {
                                    totalAmount=0;
                                    totalAmount = model.price + totalAmount;
                                  }
                                else{
                                  totalAmount = model.price + totalAmount;
                                }
                                print('Price $totalAmount');
                                print('index $index');
                                print(model.toJson());
                                print(
                                    'Lenghth ${snapshot.data.documents.length-1}');
                                if (snapshot.data.documents.length - 1 ==
                                    index) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Provider.of<TotalAmount>(context,
                                            listen: false)
                                        .display(totalAmount);
                                    // Add Your Code here.
                                  });
                                }
                                return sourceInfo(model, context,
                                    removeCartFunction: () =>
                                        removeItemInCart(model.isbn));
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
  startBuildingCart() {
    return SliverToBoxAdapter(
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.insert_emoticon, color: Colors.white),
                Text('You dont have any product in cart'),
                Text('Start building your cart now!!'),
              ],
            )),
      ),
    );
  }

  removeItemInCart(String productID) {
    print('Someone called me');
    List temp = EcommerceApp.sharedPreferences.getStringList(
      EcommerceApp.userCartList,
    );
    temp.remove(productID);

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({EcommerceApp.userCartList: temp}).then((_) {

      Fluttertoast.showToast(msg: 'Item Removed Succesfully');
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, temp);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
      totalAmount=0;
      setState(() {

      });
    });
  }
}
