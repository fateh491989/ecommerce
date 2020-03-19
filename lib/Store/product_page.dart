import 'package:ecommerce/Widgets/customAppBar.dart';
import 'package:ecommerce/Widgets/myDrawer.dart';
import 'package:ecommerce/notifiers/BookQuantity.dart';
import 'package:ecommerce/modals/book.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Store/storehome.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class ProductPage extends StatefulWidget {
  final BookModel bookModel;

  ProductPage({this.bookModel});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantityOfBooks = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: ListView(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, left: 18.0),
                      child: Text(widget.bookModel.title,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Wrap(
                      children: <Widget>[
                        for (int i = 0;
                            i < widget.bookModel.authors.length;
                            i++)
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Chip(
                              label: Text(
                                widget.bookModel.authors[i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.primaries[
                                        i % widget.bookModel.authors.length]),
                              ),
                              backgroundColor: Colors.primaries[
                                      i % widget.bookModel.authors.length]
                                  .withOpacity(0.5),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Center(
                        child: card(
                            primaryColor: Colors.red,
                            imgPath: widget.bookModel.thumbnailUrl)),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
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
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "M.R.P.: ₹",
                        style: TextStyle(),
                      ),
                      Text(
                        "1500.0",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Price: ",
                        style: TextStyle(),
                      ),
                      Text(
                        "₹",
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                      Text(
                          widget.bookModel.price.toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "You save: ",
                        style: TextStyle(),
                      ),
                      Text(
                        "₹",
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                      Text(
                        "75.0",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.only(top: 10.0, left: 20.0),
//                  child: InkWell(
//                    onTap: () {
//                      showDialog(
//                        context: context,
//                        builder: (context) => AlertDialog(
//                          title: Text("Qty"),
//                          content: Container(
//                            height: 500.0,
//                            width: 200.0,
//                            child: ListView.builder(
//                              itemCount: 15,
//                              itemBuilder: (_, index) {
//                                return ListTile(
//                                    title: Text((index + 1).toString()),
//                                    subtitle: Divider(
//                                      height: 5,
//                                    ),
//                                    onTap: () {
//                                      Provider.of<BookQuantity>(context,
//                                              listen: false)
//                                          .display(index + 1);
//                                      Navigator.pop(context);
//                                    });
//                              },
//                            ),
//                          ),
//                        ),
//                      );
//                    },
//                    child: Container(
//                      width: 105.0,
//                      //height: 50,
//                      decoration: BoxDecoration(
//                          border: Border.all(color: Colors.black87, width: 1.0),
//                          gradient: LinearGradient(
//                              colors: [
//                                Colors.grey.withOpacity(0.4),
//                                Colors.grey.withOpacity(0.8),
//                              ],
//                              begin: Alignment.topCenter,
//                              end: Alignment.bottomCenter)),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Consumer<BookQuantity>(builder: (_, quantity, __) {
//                            return Text(
//                              "Quantity: ${quantity.noOfBooks}",
//                              style: TextStyle(),
//                            );
//                          }),
//                          Icon(Icons.arrow_drop_down),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(top: 30.0),
//                  child: Center(
//                    child: InkWell(
//                      onTap: () {
//                        Route route =
//                            MaterialPageRoute(builder: (_) => CartPage());
//                        Navigator.push(context, route);
//                      },
//                      child: Container(
//                        decoration: BoxDecoration(
//                            border: Border.all(
//                                color: Colors.deepOrange, width: 1.0),
//                            gradient: LinearGradient(
//                                colors: [
//                                  Colors.orangeAccent,
//                                  Colors.deepOrange
//                                ],
//                                begin: Alignment.topCenter,
//                                end: Alignment.bottomCenter)),
//                        width: MediaQuery.of(context).size.width - 40.0,
//                        height: 50.0,
//                        child: Center(child: Text("Buy Now")),
//                      ),
//                    ),
//                  ),
//                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: InkWell(
                      onTap: () =>
                          checkItemInCart(widget.bookModel.isbn, context),
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.orange, width: 1.0),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.orangeAccent.withOpacity(0.4),
                                  Colors.orange.withBlue(56)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        width: MediaQuery.of(context).size.width - 40.0,
                        height: 50.0,
                        child: Center(child: Text("Add to Cart")),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 10.0),
                  child: Text(
                    "About this Item",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black87,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.bookModel.longDescription,
                            //"There are several things to consider in order to help your book achieve its greatest potential discoverability. Readers, librarians, and retailers can't purchase a book they can't find, and your book metadata is responsible for whether or not your book pops up when they type in search terms relevant to your book. Book metadata may sound complicated, but it consists of all the information that describes your book, including: your title, subtitle, series name, price, trim size, author name, book description, and more. There are two metadata fields for your book description: the long book description and the short book description. Although both play a role in driving traffic to your book, they have distinct differences.",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                                color: Colors.blueGrey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black87,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Features",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0,
                                  right: 30.0,
                                  top: 20.0,
                                  bottom: 20.0),
                              child: Table(
                                border: TableBorder.all(
                                    width: 1.0, color: Colors.black87),
                                children: [
                                  TableRow(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        height: 70.0,
                                        color: Colors.grey.withOpacity(0.7),
                                        child: Center(
                                          child: Text("Publisher "),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        height: 70.0,
                                        color: Colors.grey.withOpacity(0.2),
                                        child: Center(
                                          child: Text("Publisher Name"),
                                        ),
                                      )
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        height: 70.0,
                                        color: Colors.grey.withOpacity(0.7),
                                        child: Center(
                                          child: Text("Publication Date"),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        height: 70.0,
                                        color: Colors.grey.withOpacity(0.2),
                                        child: Center(
                                          child: Text("Publisher Name"),
                                        ),
                                      )
                                    ],
                                  ),
                                  TableRow(children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      height: 70.0,
                                      color: Colors.grey.withOpacity(0.7),
                                      child: Center(
                                        child: Text("Language"),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      height: 70.0,
                                      color: Colors.grey.withOpacity(0.2),
                                      child: Center(
                                        child: Text("English"),
                                      ),
                                    )
                                  ])
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
