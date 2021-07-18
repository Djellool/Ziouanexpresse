import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:ziouanexpress/Models/CodePoints.dart';
import 'package:ziouanexpress/Models/Historique.dart';
import 'package:ziouanexpress/Models/HistoriqueDetail.dart';
import 'package:ziouanexpress/Models/Promotion.dart';
import 'package:ziouanexpress/Provider/dio.dart';

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
      Dio.Response response = await dio().post('/ClientPromo/',
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

  Future<void> extrairepromo(BuildContext context, String token,
      String idclient, List<String> codes) async {
    try {
      var body = jsonEncode(codes);
      print(body.toString());
      Dio.Response response = await dio().post('/SetPromo/' + idclient,
          data: body,
          options: Dio.Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      print(response.statusCode);
      print(response.data.toString());
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
                message: "Operation Successful !",
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

  Future<String> getadresse(String token, String wilaya) async {
    try {
      Dio.Response response = await dio().get('/Bureau/' + wilaya.toString(),
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        print("Response = " + response.data.toString());
        return response.data.toString();
      }
    } on Dio.DioError catch (e) {
      print(e);
    }
    return null;
  }
}
