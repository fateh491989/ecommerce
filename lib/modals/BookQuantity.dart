import 'package:flutter/foundation.dart';

class BookQuantity with ChangeNotifier {
  int _noOfBooks = 0;

  int get noOfBooks => _noOfBooks;

  display(int number) {
    _noOfBooks = number;
    notifyListeners();
  }
}
