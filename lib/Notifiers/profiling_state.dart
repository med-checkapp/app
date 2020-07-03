import 'package:flutter/material.dart';

class ProfilingState with ChangeNotifier {
  bool _ageFilled;
  bool _sexFilled;

  ProfilingState() {
    _ageFilled = false;
    _sexFilled = false;
  }

  bool get filled => _ageFilled && _sexFilled;

  void fillAge() {
    _ageFilled = true;
    notifyListeners();
  }

  void clearAge() {
    _ageFilled = false;
    notifyListeners();
  }

  void fillSex() {
    _sexFilled = !_sexFilled;
    notifyListeners();
  }

  void clearSex() {
    _sexFilled = false;
    notifyListeners();
  }

  bool get sexo => _sexFilled;
  bool get idade => _ageFilled;
}
