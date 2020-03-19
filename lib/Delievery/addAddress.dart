import 'package:ecommerce/Config/config.dart';
import 'package:ecommerce/Widgets/customAppBar.dart';
import 'package:ecommerce/modals/address.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  final _cName = TextEditingController();
  final _cPhoneNumber = TextEditingController();
  final _cFlatNumber = TextEditingController();
  final _cArea = TextEditingController();
  final _clandmark = TextEditingController();
  final _cCity = TextEditingController();
  final _cState = TextEditingController();
  final _cPincode = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: MyAppBar(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (formKey.currentState.validate()) {
              final model = AddressModel(
                  name: _cName.text,
                  state: _cState.text,
                  pincode: _cPincode.text,
                  phoneNumber: _cPincode.text,
                  landmark: _clandmark.text,
                  flatNumber: _cFlatNumber.text,
                  city: _cCity.text,
                  area: _cArea.text)
                  .toJson();
              EcommerceApp.firestore
                  .collection(EcommerceApp.collectionUser)
                  .document(
                  EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.subCollectionAddress)
                  .document(DateTime.now().millisecondsSinceEpoch.toString())
                  .setData(model).then((_){
                final snackbar = SnackBar(content: Text('Address added successfully'));
                scaffoldKey.currentState.showSnackBar(snackbar);
                FocusScope.of(context).requestFocus(FocusNode());
                formKey.currentState.reset();
              });
            }
          },
          label: Text('Done'),
          backgroundColor: Colors.deepPurple,
          icon: Icon(Icons.check),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add address',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      MyTextField(
                        hint: 'Name',
                        controller: _cName,
                      ),
                      MyTextField(
                        hint: 'Phone Number',
                        controller: _cPhoneNumber,
                      ),
                      MyTextField(
                        hint: 'Flat Number',
                        controller: _cFlatNumber,
                      ),
                      MyTextField(
                        hint: 'Area',
                        controller: _cArea,
                      ),
                      MyTextField(
                        hint: 'Landmark',
                        controller: _clandmark,
                      ),
                      MyTextField(
                        hint: 'City',
                        controller: _cCity,
                      ),
                      MyTextField(
                        hint: 'State',
                        controller: _cState,
                      ),
                      MyTextField(
                        hint: 'Pincode',
                        controller: _cPincode,
                      ),
                    ],
                  )),

            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const MyTextField({Key key, this.hint, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (value) => value.isEmpty ? 'Field can\'t be blank' : null,
      ),
    );
  }
}
