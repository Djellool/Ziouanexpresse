import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:ziouanexpress/Models/CodePoints.dart';
import 'package:ziouanexpress/Models/Historique.dart';
import 'package:ziouanexpress/Models/HistoriqueDetail.dart';
import 'package:ziouanexpress/Models/Promotion.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Provider/dio.dart';
import 'package:ziouanexpress/Screens/Views/Login-Inscription/PasswordCode.dart';

class ApiCalls {
  Future<List<Historique>> getHistorique(String token, int idClient) async {
    Dio.Response response = await dio().get(
        '/Client/ShowHistorique/' + idClient.toString(),
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
    if (response.statusCode == 200) {
      var jsonResponse = response.data as List;
      return jsonResponse.map((e) => new Historique.fromJson(e)).toList();
    }
    return null;
  }

  Future<HistoriqueDetail> getHistoriqueDetail(
      String token, int idLivaison) async {
    try {
      Dio.Response response = await dio().get(
          '/Client/ShowHistoriqueDetail/' + idLivaison.toString(),
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return HistoriqueDetail.fromJson(response.data);
      }
    } on Dio.DioError catch (e) {
      print(e.error.toString());
    }

    return null;
  }

  Future<List<Promotions>> getPromotions(String token, int idClient) async {
    Dio.Response response = await dio().get('/Promotion/' + idClient.toString(),
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
    if (response.statusCode == 200) {
      var jsonResponse = response.data as List;
      return jsonResponse.map((e) => new Promotions.fromJson(e)).toList();
    }
    return null;
  }

  Future<void> insererCode(BuildContext context, String token, Map data) async {
    try {
      Dio.Response response = await dio().post('/ClientPromo',
          data: data,
          options: Dio.Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response);
        if (response.data.toString() == "operation reussite") {
          return showTopSnackBar(
              context,
              CustomSnackBar.success(
                backgroundColor: Colors.greenAccent[700],
                textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "Nunito",
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.w700),
                message: "Le code promo a été ajouté avec succés !",
              ));
        } else if (response.data.toString() == "code non valide") {
          return showTopSnackBar(
              context,
              CustomSnackBar.error(
                backgroundColor: Colors.redAccent[700],
                textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "Nunito",
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.w700),
                message: "Ce code promo n'est pas valide !",
              ));
        } else if (response.data.toString() == "Code deja utilisé") {
          return showTopSnackBar(
              context,
              CustomSnackBar.info(
                backgroundColor: Colors.orangeAccent[700],
                textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "Nunito",
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.w700),
                message: "Vous avez déja utilisé ce code promo !!",
              ));
        }
        return null;
      }
    } on Dio.DioError catch (e) {
      print(e.toString());
    }
  }

  Future<CodePoints> showCodePoints(String token, int idClient) async {
    try {
      Dio.Response response = await dio().get(
          '/Client/ShowCodenPoints/' + idClient.toString(),
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return CodePoints.fromJson(response.data);
      }
    } on Dio.DioError catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> changerPassword(
      BuildContext context, String token, int idClient, Map data) async {
    try {
      Dio.Response response =
          await dio().post('/Client/ChangePassword/' + idClient.toString(),
              data: data,
              options: Dio.Options(
                  followRedirects: false,
                  validateStatus: (status) {
                    return status < 500;
                  }));
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        return showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: Colors.greenAccent[700],
              textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "Nunito",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.w700),
              message: "Votre mot de passe a été changé",
            ));
      }
    } on Dio.DioError catch (e) {
      print(e.error.toString());
    }
    return null;
  }

  Future<void> changeClientInfo(
      BuildContext context, Map data, String idClient, String token) async {
    print("here");
    Dio.Response response =
        await dio().patch(Uri.encodeFull('/Client/' + idClient),
            data: jsonEncode(data),
            options: Dio.Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
              contentType: "application/json",
            ));
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.data.toString() == "Operation reussite") {
        print(data.toString());
        Provider.of<AuthProvider>(context, listen: false).changeClient(
            data['nom'], data['prenom'], data['email'], data['telephone']);
        Navigator.pop(context, true);
        showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: Colors.greenAccent[700],
              textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "Nunito",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.w700),
              message: "Vos informations ont été changé avec succés",
            ));
      } else {
        return showTopSnackBar(
            context,
            CustomSnackBar.error(
              backgroundColor: Colors.redAccent[700],
              textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "Nunito",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.w700),
              message: "Adresse mail ou numéro de téléphone deja utilisés",
            ));
      }
    } else {
      return showTopSnackBar(
        context,
        CustomSnackBar.error(
            backgroundColor: Colors.redAccent[700],
            textStyle: TextStyle(
                color: Colors.white,
                fontFamily: "Nunito",
                fontSize: ResponsiveFlutter.of(context).fontSize(2),
                fontWeight: FontWeight.w700),
            message:
                'Une erreur s\'est produite, veuillez réessayer plus tard !'),
      );
    }
  }

  Future<void> inscription(Map data, BuildContext context) async {
    Dio.Response response = await dio().post('/Client',
        data: jsonEncode(data),
        options: Dio.Options(
          contentType: "application/json",
        ));
    Map creds = {
      "telephone": data["telephone"],
      "password": data["password"],
      "device_name": data["device_name"],
    };
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      if (response.data.toString() == "operation reussite") {
        Provider.of<AuthProvider>(context, listen: false).login(context, creds);
        Navigator.pop(context);
        Navigator.pop(context);
        showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: Colors.greenAccent[700],
              textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "Nunito",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.w700),
              message: "Inscription réussite",
            ));
        EasyLoading.dismiss();
      } else {
        showTopSnackBar(
            context,
            CustomSnackBar.error(
              backgroundColor: Colors.redAccent[700],
              textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "Nunito",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.w700),
              message: "Adresse mail ou numéro de téléphone deja utilisés",
            ));
        EasyLoading.dismiss();
      }
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
            backgroundColor: Colors.redAccent[700],
            textStyle: TextStyle(
                color: Colors.white,
                fontFamily: "Nunito",
                fontSize: ResponsiveFlutter.of(context).fontSize(2),
                fontWeight: FontWeight.w700),
            message:
                'Une erreur s\'est produite, veuillez réessayer plus tard !'),
      );
      EasyLoading.dismiss();
    }
  }

  Future<void> sendEmail(BuildContext context, Map data) async {
    try {
      Dio.Response response = await dio().post('/SendMail',
          data: data,
          options: Dio.Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (response.data.toString() == "Opetation reussite")
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PasswordCodeScreen()));
        else
          showTopSnackBar(
              context,
              CustomSnackBar.error(
                backgroundColor: Colors.redAccent[700],
                textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "Nunito",
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.w700),
                message:
                    "Numéro de téléphone que vous avez introduit est incorrect",
              ));
        EasyLoading.dismiss();
      } else {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
              backgroundColor: Colors.redAccent[700],
              textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: "Nunito",
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.w700),
              message:
                  'Une erreur s\'est produite, veuillez réessayer plus tard !'),
        );
        EasyLoading.dismiss();
      }
    } on Dio.DioError catch (e) {
      print(e.error.toString());
    }
  }
}
