import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Provider/commande.dart';

import 'globalvariables.dart';

class HelperMethods {
  static double generateRandomNumber(int max) {
    var randomGenerator = Random();
    int randInt = randomGenerator.nextInt(max);

    return randInt.toDouble();
  }

  static sendNotification(String token, context, String rideid) async {
    var provider = Provider.of<CommandeProvider>(context, listen: false);
    var provider2 = Provider.of<AuthProvider>(context, listen: false);

    String pickup = provider.locationexp;
    /*String variable = getsmalllocation(pickup);*/
    String dropoff = provider.locationdes;

    String nom = provider2.client.nom;
    String prenom = provider2.client.prenom;
    String tel = provider2.client.telephone;

    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': 'key=' + serverkey,
    };

    Map notificationMap = {
      'title': 'NEW TRIP REQUEST',
      'body': 'De $pickup vers $dropoff'
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'content_available': true,
      'nom': nom,
      'prenom': prenom,
      'pickup': pickup,
      'dropoff': dropoff,
      'tel': tel,
      'prix': 1500,
      'rideid': rideid,
    };

    Map bodyMap = {
      'notification': notificationMap,
      'data': dataMap,
      'priority': 'high',
      'to': token
    };

    var response = await http.post('https://fcm.googleapis.com/fcm/send',
        headers: headerMap, body: jsonEncode(bodyMap));

    print(response.body);
  }

  static String getsmalllocation(String location) {
    final startIndex = location.indexOf(",");
    final endIndex = location.lastIndexOf(",");
    final result = location.substring(startIndex + 1, endIndex).trim();
    print(result);
    return result;
  }
}
