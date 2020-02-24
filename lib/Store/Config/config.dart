import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EcommerceApp{
  // App Information
   static const String appName = 'Fresh Genie';



   // Firestore
   static SharedPreferences sharedPreferences;
   static FirebaseUser user;
   static FirebaseAuth auth;
   static Firestore firestore ;

   // Firebase Collection name
   static String collectionUser = "users";
   static String collectionAllBooks = "books";
   static String userCartList = 'userCart';

   //Strings
   static String signInText = "Sign in using Phone Number";
   static String signIn = "Sign In";
   static String next = "Next";
   static String tapButton  = "Tap Next to verify your account with phone number. "
       "You don`t need to enter verification code manually if number is installed in your phone";
   static String enterPhoneNumber  = "Enter your phone number";
   static String sendSMS  = "We will send an SMS message to verify your phone number.";
   static String enterName  = "Enter your name";
   static String done  = "Done";

   // User Detail
   static final String userName = 'name';
   static final String userEmail = 'email';
   static final String userPhotoUrl = 'photoUrl';
   static final String userUID = 'uid';
   static final String userAvatarUrl = 'url';
   static final String userJoinedTeams = 'joinedTeams';


   // BOOKs field

}