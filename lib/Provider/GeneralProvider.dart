import 'package:flutter/cupertino.dart';

class GeneralProvider extends ChangeNotifier {
  bool _loginVisibility = true;

  bool get loginVisibility => _loginVisibility;

  void changeLoginVisibility() {
    _loginVisibility = !_loginVisibility;
    notifyListeners();
  }
}
