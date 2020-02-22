import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Store/Authentication/authenication.dart';
import 'Store/Config/config.dart';
import 'Store/homepage.dart';
import 'storehome.dart';
//List<String> cartItems;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.firestore = Firestore.instance;
  //cartItems = [];
  //TODO Delete this line
  await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, ['garbageValue']);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoreHome()
        //AllTeams()
        //SplashScreen()
      //AuthenticScreen(),
      //PLayerProfile()
    );
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
    Timer(
        Duration(seconds: 3),
            () async {
          if(await EcommerceApp.auth.currentUser()!=null){
            Route newRoute = MaterialPageRoute(builder: (_)=>StoreHomePage());
            Navigator.pushReplacement(context, newRoute);
          }
          else{
            /// Not SignedIn
            Route newRoute = MaterialPageRoute(builder: (_)=>AuthenticScreen());
            Navigator.pushReplacement(context, newRoute);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: Text('Welcome To PaintBall Application'),
        ),
      ),
    );
  }
}

