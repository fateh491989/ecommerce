import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Authentication/authenication.dart';
import '../Config/config.dart';
import '../Widgets/customTextField.dart';
import '../dialogs/errorDialog.dart';
import '../dialogs/loadingDialog.dart';
import '../homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Login to your account',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    data: Icons.person_outline,
                    controller: _emailController,
                    hintText: 'Email',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    data: Icons.lock_outline,
                    controller: _passwordController,
                    hintText: 'Password',
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                 _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty
                        ? _login()
                        : showDialog(
                            context: context,
                            builder: (con) {
                              return ErrorAlertDialog(
                                message: 'Please fill the desired fields',
                              );
                            });
              },
              color: Colors.redAccent,
              child: Text('Log in'),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 3,
              width: _screenWidth * 0.8,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),

          ],
        ),
      ),
    );
  }

  void _login() async {
    showDialog(
        context: context,
        builder: (con) {
          return LoadingAlertDialog(
            message: 'Please wait',
          );
        });
    FirebaseUser currentUser;
    await _auth
        .signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (con) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      readDataToDataBase(currentUser).then((s) {
        Navigator.pop(context);
        // TODO navigate to homescreen
        Route route = MaterialPageRoute(builder: (context) => StoreHomePage());
        Navigator.pushReplacement(context, route);
      });
    } else {
      //   _success = false;
    }
  }


}

Future readDataToDataBase(FirebaseUser currentUser) async {
   await EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(currentUser.uid).get().then((snapshot) async {
        print(snapshot.data);
     await EcommerceApp.sharedPreferences
         .setString(EcommerceApp.userUID, snapshot.data[EcommerceApp.userUID]);
     await EcommerceApp.sharedPreferences
         .setString(EcommerceApp.userEmail, snapshot.data[EcommerceApp.userEmail]);
        await EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userName, snapshot.data[EcommerceApp.userName]);
        await EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userAvatarUrl, snapshot.data[EcommerceApp.userAvatarUrl]);
        await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, snapshot.data[EcommerceApp.userCartList]);
  });
//      .setData({
//    DeliveryApp.userUID: currentUser.uid,
//    DeliveryApp.userEmail: currentUser.email,
//  });

}


final FirebaseAuth _auth = FirebaseAuth.instance;
