import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EcommerceApp{
  // App Information
   static const String appName = 'Book Store';



   // Firestore
   static SharedPreferences sharedPreferences;
   static FirebaseUser user;
   static FirebaseAuth auth;
   static Firestore firestore ;

   // Firebase Collection name
   static String collectionUser = "users";
   static String collectionOrders = "orders";  // subCollection
   static String collectionAllBooks = "books";
   static String userCartList = 'userCart';
   static String subCollectionAddress = 'userAddress';

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

   // Order fields
   static final String addressID = 'addressID';
   static final String totalAmount = 'totalAmount';
   static final String productID = 'productIDs';
   static final String paymentDetails ='paymentDetails';
   static final String orderTime ='orderTime';
   static final String isSuccess ='isSuccess';

}