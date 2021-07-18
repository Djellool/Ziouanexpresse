import 'package:flutter/material.dart';

class CommandeProvider extends ChangeNotifier {
  String _locationexp = "";
  String _locationdes = "";
  String _wilayaexp = "";
  String _wilayades = "";

  String _dimension = "";
  String _fragilite = "";
  String _nomdest = "";
  String _prenomdest = "";
  String _teldest = "";
  double _poids = 0;
  double _valeur = 0;
  double _duration = 0;
  double _distance = 0;
  double _prix = 0;
  double _prixavecpromo = 0;
  String _localitydest = "";
  String _localityexp = "";
  int _interwilaya = 0;

  String get locationexp => _locationexp;
  String get locationdes => _locationdes;
  String get dimension => _dimension;
  String get fragilite => _fragilite;
  double get poids => _poids;
  double get valeur => _valeur;
  double get duration => _duration;
  double get distance => _distance;
  String get nomdest => _nomdest;
  String get prenomdest => _prenomdest;
  String get teldest => _teldest;
  double get prix => _prix;
  double get prixavecpromo => _prixavecpromo;
  String get wilayaexp => _wilayaexp;
  String get wilayades => _wilayades;
  String get localitydest => _localitydest;
  String get localityexp => _localityexp;
  int get interwilaya => _interwilaya;

  void changelocationexp(String location) {
    this._locationexp = location;
    notifyListeners();
  }

  void changelocationdes(String location) {
    this._locationdes = location;
    notifyListeners();
  }

  void changeinterwilaya(int interwilaya) {
    this._interwilaya = interwilaya;
    notifyListeners();
  }

  void changelocalityexp(String location) {
    this._localityexp = location;
    notifyListeners();
  }

  void changelocalitydes(String location) {
    this._localitydest = location;
    notifyListeners();
  }

  void changewilayaexp(String wilaya) {
    this._wilayaexp = wilaya;
    notifyListeners();
  }

  void changewilayades(String location) {
    this._wilayades = location;
    notifyListeners();
  }

  void changeprix(double prix) {
    this._prix = prix;
    notifyListeners();
  }

  void changeprixavecpromo(double prixavecpromo) {
    this._prixavecpromo = prixavecpromo;
    notifyListeners();
  }

  void changenomdest(String nomdest) {
    this._nomdest = nomdest;
    notifyListeners();
  }

  void changeprenomdest(String prenomdest) {
    this._prenomdest = prenomdest;
    notifyListeners();
  }

  void changeteldest(String teldest) {
    this._teldest = teldest;
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

  void changeduration(double duration) {
    this._duration = duration;
    notifyListeners();
  }

  void changedistance(double distance) {
    this._distance = distance;
    notifyListeners();
  }
}
