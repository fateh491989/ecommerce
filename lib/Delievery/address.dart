import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Config/config.dart';
import 'package:ecommerce/Payment/payment.dart';
import 'package:ecommerce/Widgets/customAppBar.dart';
import 'package:ecommerce/Widgets/loadingWidget.dart';
import 'package:ecommerce/Widgets/wideButton.dart';
import 'package:ecommerce/modals/address.dart';
import 'package:ecommerce/notifiers/changeAddresss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addAddress.dart';

class Address extends StatefulWidget {
  final double totalAmount;
  const Address({Key key, this.totalAmount}) : super(key: key);
  @override
  _AddressState createState() => _AddressState();
}

int currentIndex = 0;

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select address',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            Consumer<AddressChanger>(builder: (context, address, _) {
              return Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: EcommerceApp.firestore
                      .collection(EcommerceApp.collectionUser)
                      .document(EcommerceApp.sharedPreferences
                          .getString(EcommerceApp.userUID))
                      .collection(EcommerceApp.subCollectionAddress)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(child: LoadingWidget())
                        : snapshot.data.documents.length == 0
                            ? noAddressCard()
                            : ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AddressCard(
                                    currentIndex: address.count,
                                    value: index,
                                    addressID: snapshot.data.documents[index].documentID,
                                    totalAmount: widget.totalAmount,
                                    model: AddressModel.fromJson(
                                        snapshot.data.documents[index].data),
                                  );
                                });
                  },
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Route route = MaterialPageRoute(builder: (_) => AddAddress());
              Navigator.push(context, route);
            },
            label: Text('Add Address'),
          backgroundColor: Colors.deepPurple,
          icon: Icon(Icons.add_location),
        ),
      ),
    );
  }

  noAddressCard() {
    return Card(
      color: Colors.deepPurple.withOpacity(0.5),
      child: Container(
          height: 100,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add_location, color: Colors.white),
              Text('You dont have any address with us'),
              Text('Add your address so that we can deliever prodoct !!'),
            ],
          )),
    );
  }
}

class AddressCard extends StatefulWidget {
  final AddressModel model;
  final int currentIndex;
  final int value;
  final String addressID;
  final double totalAmount;
  const AddressCard({Key key, this.model, this.currentIndex, this.value,  this.addressID, this.totalAmount})
      : super(key: key);

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        Provider.of<AddressChanger>(context, listen: false)
            .displayResult(widget.value);

      },
      child: Card(
        color: Colors.black12,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Radio(
                  groupValue: widget.currentIndex,
                  value: widget.value,
                  activeColor: Colors.deepPurple,
                  onChanged: (val) {
                    Provider.of<AddressChanger>(context, listen: false)
                        .displayResult(val);
                    print(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: _screenWidth * 0.8,
                      child: Table(
                        //border: TableBorder.all(),
                        children: [
                          TableRow(children: [
                            KeyText(message: 'Name'),
                            Text(widget.model.name),
                          ]),
                          TableRow(children: [
                            KeyText(message: 'Phone Number'),
                            Text(widget.model.phoneNumber),
                          ]),
                          TableRow(children: [
                            KeyText(message: 'Flat Number'),
                            Text(widget.model.flatNumber),
                          ]),
                          TableRow(children: [
                            KeyText(message: 'Area'),
                            Text(widget.model.area),
                          ]),
                          TableRow(children: [
                            KeyText(message: 'Landmark'),
                            Text(widget.model.landmark),
                          ]),
                          TableRow(children: [
                            KeyText(message: 'City'),
                            Text(widget.model.city),
                          ]),
                          TableRow(children: [
                            KeyText(message: 'State'),
                            Text(widget.model.state),
                          ]),
                          TableRow(children: [
                            KeyText(
                              message: 'pincode',
                            ),
                            Text(widget.model.pincode),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            widget.value == Provider.of<AddressChanger>(context).count
                ? WideButton(
                    message: 'Proceed',
                    onPressed: () {
                      Route route = MaterialPageRoute(builder: (c)=>PaymentPage(
                        addressID: widget.addressID,
                        totalAmount: widget.totalAmount
                      ));
                      Navigator.push(context, route);
                      print(widget.model.toJson());
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}





class KeyText extends StatelessWidget {
  final String message;

  KeyText({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}

// in payment page make a section of select payment method on selection of upi navigate user to new screen with upi options like paytm, phonepay and complete payment
