import 'package:flutter/cupertino.dart';

class GeneralProvider extends ChangeNotifier {
  bool _loginVisibility = true;
  bool _renvoyerIns = false;
  bool _profileVisibility = true;

  bool get loginVisibility => _loginVisibility;
  bool get renvoyerIns => _renvoyerIns;
  bool get profileVisibility => _profileVisibility;

  void changeLoginVisibility() {
    _loginVisibility = !_loginVisibility;
    notifyListeners();
  }

  void changeRenvoyerIns(bool renvoyerIns) {
    if (renvoyerIns == null) {
      _renvoyerIns = !_renvoyerIns;
    } else {
      _renvoyerIns = renvoyerIns;
    }
    notifyListeners();
  }

  void changeProfileVisibility() {
    _profileVisibility = !_profileVisibility;
  }
}
