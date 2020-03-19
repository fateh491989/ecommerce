import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Payment/paymentDetailsaPage.dart';
import 'package:ecommerce/modals/book.dart';
import 'package:ecommerce/Config/light_color.dart';
import 'package:ecommerce/Config/theme.dart';
import 'package:flutter/material.dart';

import '../Store/storehome.dart';


class OrderCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;
  const OrderCard({Key key, this.data, this.itemCount, this.orderID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Route route = MaterialPageRoute(builder: (_)=>OrderDetails(
          orderID: orderID
        ));
        Navigator.push(context, route);
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12
            )
          ),
          padding: EdgeInsets.all(10),

          margin: EdgeInsets.all(10),
          height: itemCount*190.0,
          child: ListView.builder(
              itemCount: itemCount,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_,index){

                print("Data in orderCard ${data[index].data} ");
                print(data.length);
                BookModel model = BookModel.fromJson(data[index].data);
                return sourceInfo(model, context);
              }),

      ),
    );
  }
}
Widget sourceInfo(BookModel model, BuildContext context,
    {Color background}) {
  width =  MediaQuery.of(context).size.width;
  return  Container(
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
                  ],
                ))
          ],
        ),
  );
}
