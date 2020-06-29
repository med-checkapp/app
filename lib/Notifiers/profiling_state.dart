import 'package:flutter/material.dart';

class ProfilingState with ChangeNotifier {
  bool _idadePreenchida;
  bool _sexoPreenchido;

  ProfilingState() {
    _idadePreenchida = false;
    _sexoPreenchido = false;
  }

  bool filled() => _idadePreenchida && _sexoPreenchido;

  void fillIdade() {
      _idadePreenchida = true;
      notifyListeners();
  }

  void clearIdade() {
    _idadePreenchida = false;
    notifyListeners();
  }

  void fillSexo() {
    _sexoPreenchido = !_sexoPreenchido;
    notifyListeners();
  }

  void clearSexo() {
    _sexoPreenchido = false;
    notifyListeners();
}

  bool getSexo() => _sexoPreenchido;
  bool getIdade() => _idadePreenchida;
}
