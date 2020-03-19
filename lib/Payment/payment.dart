import 'package:ecommerce/Payment/paymentDetailsaPage.dart';
import 'package:ecommerce/Config/config.dart';
import 'package:ecommerce/Widgets/customAppBar.dart';
import 'package:ecommerce/Widgets/wideButton.dart';
import 'package:ecommerce/notifiers/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upi_india/upi_india.dart';

class PaymentPage extends StatefulWidget {
  final String addressID;
  final double totalAmount;

  const PaymentPage({Key key, this.addressID, this.totalAmount})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List details = [
    ['Paytm', 'PhonePe', 'GooglePay'],
    ['7973268843@PAYTM', '7973268843@ybl', 'fss491989@@okicici'],
    [UpiIndiaApps.PayTM, UpiIndiaApps.PhonePe, UpiIndiaApps.GooglePay]
  ];
  static const String receiverName = 'YourBussinessName';

  Future transaction;

  Future<String> initiateTransaction(String appType, String receiverUPIID,
      String transactionRefID, double amount) async {
    UpiIndia upi = new UpiIndia(
      app: appType,
      receiverUpiId: receiverUPIID,
      receiverName: receiverName,
      transactionRefId: transactionRefID,
      transactionNote: 'Transaction Note',
      amount: 100000,
    );
    String response = await upi.startTransaction();
    return response;
  }
  String orderID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),

                Text(
                  'Pay using UPI ₹ ${widget.totalAmount.toString()}',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),

            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: details[0].length,
                  itemBuilder: (context, index) {
                    return WideButton(
                      message: details[0][index],
                      onPressed: () {
                        print(details[1][index]);
                        transaction = initiateTransaction(
                                details[2][index],
                                details[1][index],
                                DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                widget.totalAmount)
                            .then((res) {
                          print('Printing Response $res');

                          UpiIndiaResponse _upiResponse;
                          _upiResponse = UpiIndiaResponse(res);
                          String txnId = _upiResponse.transactionId;
                          String resCode = _upiResponse.responseCode;
                          String txnRef = _upiResponse.transactionRefId;
                          String status = _upiResponse.status;
                          String approvalRef = _upiResponse.approvalRefNo;
                          bool isSuccess = false;
                          Route route;
                          String currentTime = DateTime.now()
                              .millisecondsSinceEpoch
                              .toString();
                          orderID = EcommerceApp.sharedPreferences
                              .getString(EcommerceApp.userUID)+currentTime;
                          if (status == 'success') {
                            isSuccess = true;
                            // Write  details to firebase
                            writeOrderDetails({
                              EcommerceApp.addressID: widget.addressID,
                              EcommerceApp.totalAmount: widget.totalAmount,
                              EcommerceApp.productID:
                              EcommerceApp.sharedPreferences.getStringList(
                                  EcommerceApp.userCartList),
                              EcommerceApp.paymentDetails: res,
                              EcommerceApp.orderTime: currentTime,
                              EcommerceApp.isSuccess: true,
                            }).then((_){
                              // Empty Cart
                              emptyCart();
                              route = MaterialPageRoute(
                                  builder: (_) => OrderDetails(
                                    orderID: orderID,
                                  ));
                              Navigator.push(context, route);
                            });

                          } else {
                            isSuccess = false;
                            writeOrderDetails({
                              EcommerceApp.addressID: widget.addressID,
                              EcommerceApp.totalAmount: widget.totalAmount,
                              EcommerceApp.productID:
                              EcommerceApp.sharedPreferences.getStringList(
                                  EcommerceApp.userCartList),
                              EcommerceApp.paymentDetails: res,
                              EcommerceApp.orderTime: currentTime,
                              EcommerceApp.isSuccess: false,
                            });
                            route = MaterialPageRoute(
                                builder: (_) => OrderDetails(
                                  orderID: orderID,
                                ));
                            Navigator.push(context, route);
                          }

                        });
                        setState(() {});
                      },
                    );
                  }),
            ),
            Expanded(
              child: FutureBuilder(
                future: transaction,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null)
                    return Text(' ');
                  else {
                    switch (snapshot.data.toString()) {
                      case UpiIndiaResponseError.APP_NOT_INSTALLED:
                        return Text(
                          'App not installed.',
                        );
                        break;
                      case UpiIndiaResponseError.INVALID_PARAMETERS:
                        return Text(
                          'Requested payment is invalid.',
                        );
                        break;
                      case UpiIndiaResponseError.USER_CANCELLED:
                        return Text(
                          'It seems like you cancelled the transaction.',
                        );
                        break;
                      case UpiIndiaResponseError.NULL_RESPONSE:
                        return Text(
                          'No data received',
                        );
                        break;
                      default:
                        UpiIndiaResponse _upiResponse;
                        _upiResponse = UpiIndiaResponse(snapshot.data);
                        String txnId = _upiResponse.transactionId;
                        String resCode = _upiResponse.responseCode;
                        String txnRef = _upiResponse.transactionRefId;
                        String status = _upiResponse.status;
                        String approvalRef = _upiResponse.approvalRefNo;

                        return Column(
                          children: <Widget>[
                            Text('Transaction Id: $txnId'),
                            Text('Response Code: $resCode'),
                            Text('Reference Id: $txnRef'),
                            Text('Status: $status'),
                            Text('Approval No: $approvalRef'),
                          ],
                        );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void emptyCart() {
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ['garbageValue']);
    print('Someone called me');
    List temp = EcommerceApp.sharedPreferences.getStringList(
      EcommerceApp.userCartList,
    );

    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({EcommerceApp.userCartList: temp}).then((_) {
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, temp);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
    });
  }

  Future writeOrderDetails(Map<String,dynamic> data)async {
    await EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(EcommerceApp.sharedPreferences
        .getString(EcommerceApp.userUID))
        .collection(EcommerceApp.collectionOrders)
        .document(EcommerceApp.sharedPreferences
        .getString(EcommerceApp.userUID)+data['orderTime']) // Order ID = uid+currentID
        .setData(
      data
    );
  }

}
