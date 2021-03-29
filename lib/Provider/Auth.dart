import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _authenticated = "loggedout";

  String get authenticated => _authenticated;

  void changeAuthenticated(String authenticated) {
    this._authenticated = authenticated;
    notifyListeners();
  }
}
