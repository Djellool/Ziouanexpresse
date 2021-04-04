import 'package:flutter/cupertino.dart';

class InscriptionProvider extends ChangeNotifier {
  String _nom;
  String _prenom;
  String _eMail;
  String _phoneNumber;
  String _password;
  String _passwordConf;

  String get nom => _nom;
  String get prenom => _prenom;
  String get eMail => _eMail;
  String get phoneNumber => _phoneNumber;
  String get password => _password;
  String get passwordConf => _passwordConf;

  void changeNom(String nom) {
    _nom = nom;
    notifyListeners();
  }

  void changePrenom(String prenom) {
    _prenom = prenom;
    notifyListeners();
  }

  void changeEMail(String eMail) {
    _eMail = eMail;
    notifyListeners();
  }

  void changePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void changePassword(String password) {
    _password = password;
    notifyListeners();
  }

  void changePasswordConf(String passwordConf) {
    _passwordConf = passwordConf;
    notifyListeners();
  }
}
