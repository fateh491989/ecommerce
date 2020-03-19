import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/notifiers/BookQuantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authenication.dart';
import 'Payment/paymentDetailsaPage.dart';
import 'package:ecommerce/Config/config.dart';
import 'notifiers/cartitemcounter.dart';
import 'Store/myOrders.dart';
import 'notifiers/changeAddresss.dart';
import 'notifiers/totalMoney.dart';
import 'Store/storehome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.firestore = Firestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartItemCounter()),
          ChangeNotifierProvider(create: (_) => BookQuantity()),
          ChangeNotifierProvider(create: (_) => AddressChanger()),
          ChangeNotifierProvider(create: (_) => TotalAmount()),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.deepPurple,
            ),
            home: SplashScreen()));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    Timer(Duration(seconds: 2), () async {
      if (await EcommerceApp.auth.currentUser() != null) {
        Route newRoute = MaterialPageRoute(builder: (_) => StoreHome());
        Navigator.pushReplacement(context, newRoute);
      } else {
        /// Not SignedIn
        Route newRoute = MaterialPageRoute(builder: (_) => AuthenticScreen());
        Navigator.pushReplacement(context, newRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/welcome.png'),
              Text('Welcome to Book Store'),
            ],
          ),
        ),
      ),
    );
  }
}
