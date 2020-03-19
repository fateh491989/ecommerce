import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Store/product_page.dart';
import 'package:ecommerce/notifiers/cartitemcounter.dart';
import 'package:ecommerce/Config/light_color.dart';
import 'package:ecommerce/Config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/Config/config.dart';
import '../Widgets/customAppBar.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../modals/book.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: MyAppBar(),
            ),
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('books').snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? SliverToBoxAdapter(
                          child: Center(child: LoadingWidget()),
                        )
                      : SliverStaggeredGrid.countBuilder(
                          crossAxisCount: 1,
                          staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                          itemBuilder: (context, index) {
                            BookModel model = BookModel.fromJson(
                                snapshot.data.documents[index].data);
                            return sourceInfo(model, context);
                          },
                          itemCount: snapshot.data.documents.length,
                        );
                }),
          ],
        ),
      ),
    );
  }
}

Widget sourceInfo(BookModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Route route =
          MaterialPageRoute(builder: (_) => ProductPage(bookModel: model));
      Navigator.push(context, route);
    },
    splashColor: LightColor.purple,
    child: Container(
        height: 170,
        width: width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child:
                  card(primaryColor: background, imgPath: model.thumbnailUrl),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(model.title,
                            style: TextStyle(
                                color: LightColor.purple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: background,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(model.pageCount.toString(),
                          style: TextStyle(
                            color: LightColor.grey,
                            fontSize: 14,
                          )),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      alignment: Alignment.topLeft,
                      width: 40.0,
                      height: 40.0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "50%",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "OFF",
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text("M.R.P.: ₹",
                                  style: AppTheme.h6Style.copyWith(
                                    fontSize: 14,
                                    color: LightColor.grey,
                                  )),
                              Text("1500.0",
                                  style: AppTheme.h6Style.copyWith(
                                      fontSize: 14,
                                      color: LightColor.grey,
                                      decoration: TextDecoration.lineThrough)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0.0,
                          ),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Price: ",
                                  style: AppTheme.h6Style.copyWith(
                                    fontSize: 14,
                                    color: LightColor.grey,
                                  )),
                              Text(
                                "₹",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                              Text(model.price.toString(),
                                  style: AppTheme.h6Style.copyWith(
                                    fontSize: 14,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Flexible(
                  child: Container(),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: removeCartFunction == null
                      ? IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: LightColor.purple,
                          ),
                          onPressed: () {
                            checkItemInCart(model.isbn, context);
                          })
                      : IconButton(
                          icon: Icon(
                            Icons.remove_shopping_cart,
                            color: LightColor.purple,
                          ),
                          onPressed: () {
                            print('StoreHome.dart');
                            removeCartFunction();
                            //checkItemInCart(model.isbn, context);
                          }),
                ),
                Divider(
                  height: 4,
                )
              ],
            ))
          ],
        )),
  );
}

Widget _chip(String text, Color textColor,
    {double height = 0, bool isPrimaryCard = false}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Chip(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      label: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    ),
  );
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container(
      height: 150,
      width: width * .34,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 10, color: Color(0x12000000))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Image.network(
          imgPath,
          height: 150,
          width: width * .34,
          fit: BoxFit.fill,
        ),
      ));
}

void checkItemInCart(String productID, BuildContext context) {
  print(productID);

  ///print(cartItems);
  EcommerceApp.sharedPreferences
          .getStringList(
            EcommerceApp.userCartList,
          )
          .contains(productID)
      ? Fluttertoast.showToast(msg: 'Product is already in cat')
      : addToCart(productID, context);
}

void addToCart(String productID, BuildContext context) {
  List temp = EcommerceApp.sharedPreferences.getStringList(
    EcommerceApp.userCartList,
  );
  temp.add(productID);
  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({EcommerceApp.userCartList: temp}).then((_) {
    Fluttertoast.showToast(msg: 'Item Added Succesfully');
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, temp);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}
