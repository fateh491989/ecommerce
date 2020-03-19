import 'package:flutter/cupertino.dart';

class TotalAmount extends ChangeNotifier{
  double _totalAmount = 0;

  double get totalAmount => _totalAmount;

  display(double number) async {
    _totalAmount = number;
    //+_totalAmount;
    await Future.delayed(const Duration(milliseconds: 100), (){
      notifyListeners();
    });
    //notifyListeners();
  }
}