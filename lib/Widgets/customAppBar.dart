import 'package:ecommerce/Store/cart.dart';
import 'package:ecommerce/notifiers/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text("Book Store"),
      bottom: bottom,
      backgroundColor: Colors.blueGrey,
      actions: <Widget>[
        Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (_)=>CartPage());
                  Navigator.push(context, route);
              },
            ),
            Positioned(
                child: Stack(
                  children: <Widget>[
                    Icon(Icons.brightness_1,
                        size: 20.0, color: Colors.deepPurple),
                    Positioned(
                        top: 3.0,
                        right: 4.0,
                        child: Center(
                          child: Consumer<CartItemCounter>(
                              builder: (context, counter, _) {
                                return Text(
                                  counter.count.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500),
                                );
                              }),
                        )),
                  ],
                )),
          ],
        ),
      ],
    );
  }


  // Adding 80 because height of bottom SearchBox container is 80
  @override
  // TODO: implement preferredSize
  Size get preferredSize => bottom==null?Size(56,AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}
