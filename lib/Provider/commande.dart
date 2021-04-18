import 'package:flutter/material.dart';

class CommandeProvider extends ChangeNotifier {
  String _locationexp = "";
  String _locationdes = "";

  String _dimension = "";
  String _fragilite = "";
  double _poids = 0;
  double _valeur = 0;

  String get locationexp => _locationexp;
  String get locationdes => _locationdes;
  String get dimension => _dimension;
  String get fragilite => _fragilite;
  double get poids => _poids;
  double get valeur => _valeur;

  void changelocationexp(String location) {
    this._locationexp = location;
    notifyListeners();
  }

  void changelocationdes(String location) {
    this._locationdes = location;
    notifyListeners();
  }

  void changedimension(String dimension) {
    this._dimension = dimension;
    notifyListeners();
  }

  void changefragilite(String fragilite) {
    this._fragilite = fragilite;
    notifyListeners();
  }

  void changepoids(double poids) {
    this._poids = poids;
    notifyListeners();
  }

  void changevaleur(double valeur) {
    this._valeur = valeur;
    notifyListeners();
  }
}
