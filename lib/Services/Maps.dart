import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:ziouanexpress/Assistants/requestAssistant.dart';
import 'package:ziouanexpress/Models/DirectionDetails.dart';

class Maps {
  static Future<DirectionDetails> obtainPlaceDirectionsDetails(
      BuildContext context, String pickup, String dropoff) async {
    String directionURL =
        "https://maps.googleapis.com/maps/api/directions/json?origin=" +
            pickup +
            "&destination=" +
            dropoff +
            "&key=AIzaSyAP7liOJtATNmGMiTihPlUSrW0qWvZiM44";

    DirectionDetails directiondetails = DirectionDetails();

    var res = await RequestAssistant.getRequest(directionURL);
    if (res == "Failed") {
      return null;
    }
    directiondetails.encodedPoints =
        res["routes"][0]["overview_polyline"]["points"];

    directiondetails.distanceText =
        res["routes"][0]["legs"][0]["distance"]["text"];
    directiondetails.distanceValue =
        res["routes"][0]["legs"][0]["distance"]["value"];

    directiondetails.durationText =
        res["routes"][0]["legs"][0]["duration"]["text"];
    directiondetails.durationValue =
        res["routes"][0]["legs"][0]["duration"]["value"];

    return directiondetails;
  }

  static Future<List<String>> obtainwilayalocalityfrommainadress(
      String adress) async {
    List<String> wilayalocality = List<String>();
    var kGoogleApiKey = "AIzaSyC2GWz9vj6BWyIPMGyePxIQb4aqKOcJwz4";
    var addresses =
        await Geocoder.google(kGoogleApiKey).findAddressesFromQuery(adress);
    wilayalocality.add(addresses.first.adminArea);
    wilayalocality.add(addresses.first.locality);
    return wilayalocality;
  }
}
