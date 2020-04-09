import 'package:flutter/material.dart';


class ProfilingState with ChangeNotifier {
  bool _idadePreenchida;
  bool _sexoPreenchido;

  ProfilingState(){
    _idadePreenchida = false;
    _sexoPreenchido = false;
  }

  bool filled() => _idadePreenchida && _sexoPreenchido;

  void preencherIdade()  {
    _idadePreenchida = true;
    notifyListeners();
  }

  void esvaziarIdade() {
    _idadePreenchida = false;
    notifyListeners();
  }

  void changeSexo() {
    _sexoPreenchido = !_sexoPreenchido;
    notifyListeners();
  }

  bool getSexo() => _sexoPreenchido;
}