import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:ziouanexpress/Models/Client.dart';
import 'package:ziouanexpress/Provider/dio.dart';
import 'package:ziouanexpress/Screens/Views/Profile/Profile.dart';
import 'package:ziouanexpress/Screens/Views/Profile/ProfilePassword.dart';

class AuthProvider extends ChangeNotifier {
  final storage = new FlutterSecureStorage();
  String _authenticated = "loggedout";
  String _token;
  Client _client;

  String get authenticated => _authenticated;
  String get token => _token;
  Client get client => _client;

  Future<Client> login(BuildContext context, Map creds) async {
    try {
      Dio.Response response = await dio().post('/ClientAuth',
          data: creds,
          options: Dio.Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        String token = response.data.toString();
        print(token);
        return this.tryToken(context, token);
      }
    } on Dio.DioError catch (e) {
      if (e.response.statusCode == 302) print(e);
      return null;
    }
    return null;
  }

  Future<Client> tryToken(BuildContext context, String token) async {
    if (token == null) {
      return null;
    } else {
      try {
        Dio.Response response = await dio().get('/ClientAuth',
            options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
        if (response.statusCode == 200) {
          this._client = Client.fromJson(response.data);
          this._authenticated = "loggedIN";
          this._token = token;
          await storeToken(token, _client.idClient.toString());
          notifyListeners();
        }
      } on Dio.DioError catch (e) {
        print(e.error.toString());
      }
    }
    return this._client;
  }

  Future<void> storeToken(String token, String clientId) async {
    await this.storage.write(key: "token", value: token);
    await this.storage.write(key: "", value: clientId);
  }

  Future<void> logout() async {
    try {
      Dio.Response response = await dio().get('/ClientAuth/revoke',
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        print("nice");
        cleanUp();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> cleanUp() async {
    this._client = null;
    this._authenticated = "loggedout";
    this._token = null;
    await storage.deleteAll();
  }

  void changeAuthenticated(String authenticated) {
    this._authenticated = authenticated;
    notifyListeners();
  }

  Future<Client> loginWithoutPass(BuildContext context, Map creds) async {
    try {
      Dio.Response response = await dio().post('/ResetPassword',
          data: creds,
          options: Dio.Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (response.data.toString() == "code invalide") {
          showTopSnackBar(
              context,
              CustomSnackBar.error(
                backgroundColor: Colors.redAccent[700],
                textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "Nunito",
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.w700),
                message: "Le code que vous avez introduit est incorrect",
              ));
          EasyLoading.dismiss();
        } else {
          String token = response.data.toString();
          print(token);
          EasyLoading.dismiss();
          await this.tryToken(context, token);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePassword()));
        }
      }
    } on Dio.DioError catch (e) {
      if (e.response.statusCode == 302) print(e);
      return null;
    }
    return null;
  }

  void changeClient(String nom, String prenom, String email, String telephone) {
    _client.email = email;
    _client.nom = nom;
    _client.prenom = prenom;
    _client.telephone = telephone;
    notifyListeners();
  }
}
