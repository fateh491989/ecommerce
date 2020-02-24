
import 'package:ecommerce/Store/Config/config.dart';
import 'package:flutter/foundation.dart';

class CartItemCounter extends ChangeNotifier{
  int _counter=0;
  int get count => _counter;

  displayResult(){
    //_counter++;
    print(EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length);
    _counter=EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1;
    notifyListeners();
  }

}