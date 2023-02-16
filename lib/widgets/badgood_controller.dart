import 'package:flutter/material.dart';

class BadgoodController extends ChangeNotifier {
  bool isBad = true;
  void setIsBad(bool newIsBad) {
    isBad = newIsBad;
    notifyListeners();
  }
}
