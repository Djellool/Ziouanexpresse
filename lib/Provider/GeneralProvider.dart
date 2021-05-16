import 'package:flutter/cupertino.dart';

class GeneralProvider extends ChangeNotifier {
  bool _loginVisibility = true;
  bool _renvoyerIns = false;
  bool _profileVisibility = true;
  String _eMail;
  String _nom;
  String _prenom;
  String _telephone;
  bool _renvoyer = false;
  String _forgettenPhone;

  bool get loginVisibility => _loginVisibility;
  bool get renvoyerIns => _renvoyerIns;
  bool get profileVisibility => _profileVisibility;
  String get eMail => _eMail;
  String get nom => _nom;
  String get prenom => _prenom;
  String get telephone => _telephone;
  bool get renvoyer => _renvoyer;
  String get forgettenPhone => _forgettenPhone;

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

  void changeNom(String nom) {
    _nom = nom;
  }

  void changePrenom(String prenom) {
    _prenom = prenom;
  }

  void changeEMail(String eMail) {
    _eMail = eMail;
  }

  void changePhoneNumber(String phonenumber) {
    _telephone = phonenumber;
    notifyListeners();
  }

  void changeRenvoyer(bool renvoyer) {
    if (renvoyer == null) {
      _renvoyer = !_renvoyer;
    } else {
      _renvoyer = renvoyer;
    }
  }

  void changeForgettenPhone(String forgettenPhone) {
    _forgettenPhone = forgettenPhone;
    notifyListeners();
  }
}
