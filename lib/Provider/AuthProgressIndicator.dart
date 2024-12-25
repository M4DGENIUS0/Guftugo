import 'package:flutter/material.dart';

class AuthCircularProgressIndicator extends ChangeNotifier {
  bool _circularProgressIndicator = false;

  bool get circularProgressIndicator => _circularProgressIndicator;

  set circularProgressIndicator(bool value) {
    _circularProgressIndicator = value;
    notifyListeners();
  }
}
