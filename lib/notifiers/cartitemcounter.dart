import 'package:flutter/foundation.dart';
import 'package:ecommerce/Config/config.dart';

class CartItemCounter extends ChangeNotifier{
  int _counter=EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1;
  int get count => _counter;

   Future<void> displayResult() async {

    //_counter++;
    print(EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length);
    _counter=EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1;
    await Future.delayed(const Duration(milliseconds: 100), (){
      notifyListeners();
    });

  }

}