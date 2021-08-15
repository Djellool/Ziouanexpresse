import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ziouanexpress/Provider/Auth.dart';
import 'package:ziouanexpress/Provider/commande.dart';
import 'package:ziouanexpress/Services/ApiCalls.dart';

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
    int idClient = provider2.client.idClient;
    String tel = provider2.client.telephone;
    String dimension = provider.dimension;
    String fragilite = provider.fragilite;
    String dest = provider.nomdest + " " + provider.prenomdest;
    String teldest = provider.teldest;
    double poids = provider.poids;
    double valeur = provider.valeur;
    double distance = provider.distance;
    double duration = provider.duration;
    double prix = provider.prix;
    double prixavecpromo = provider.prixavecpromo;
    String wilayadest = provider.wilayades;
    String wilayaexp = provider.wilayaexp;
    String localitydest = provider.localitydest;
    String localityexp = provider.localityexp;
    int interwilaya = provider.interwilaya;
    String adressbureau = await ApiCalls().getadresse(token, wilayaexp);
    print("Adresse du bureau = " + adressbureau.toString());

    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': 'key=' + serverkey,
    };

    Map notificationMap = {
      'title': 'Demande De Livraison !',
      'body': 'De $pickup vers $dropoff'
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'content_available': true,
      'id_client': idClient,
      'nom': nom + " " + prenom,
      'pickup': pickup,
      'dropoff': dropoff,
      'distance': distance,
      'tel': tel,
      'dest': dest,
      'teldest': teldest,
      'prix': prix,
      'prixavecpromo': prixavecpromo,
      'rideid': rideid,
      'valeur': valeur,
      'poids': poids,
      'fragilite': fragilite,
      'dimensions': dimension,
      'duration': duration,
      'wilayadest': wilayadest,
      'wilayaexp': wilayaexp,
      'localitydest': localitydest,
      'localityexp': localityexp,
      'interwilaya': interwilaya,
      'adressbureau': adressbureau,
    };

    print("Locality expediteur = " + localityexp);
    print("Locality destinataire = " + localitydest);
    Map bodyMap = {
      'notification': notificationMap,
      'data': dataMap,
      'priority': 'high',
      'to': token
    };

    await http.post('https://fcm.googleapis.com/fcm/send',
        headers: headerMap, body: jsonEncode(bodyMap));
  }

  static String getsmalllocation(String location) {
    final startIndex = location.indexOf(",");
    final endIndex = location.lastIndexOf(",");
    final result = location.substring(startIndex + 1, endIndex).trim();
    print(result);
    return result;
  }

  static int comparewilaya(String exped, String dest) {
    if (exped == dest) {
      return 1;
    } else {
      if (exped == "Algiers Province" || dest == "Algiers Province") {
        if (dest == "Wilaya d'Alger" || exped == "Wilaya d'Alger") {
          return 1;
        } else {
          return 0;
        }
      } else {
        if ((exped.contains("Province") == true &&
            dest.contains("Province") == false)) {
          String expedi = exped.substring(0, exped.indexOf("Province"));
          String expedii = expedi.replaceAll(' ', '');
          if (dest.contains(expedii)) {
            print("equivalent");
          } else {
            print("pas equivalent");
          }
        } else {
          if (exped.contains("Province") == false &&
              dest.contains("Province") == true) {
            String desti = dest.substring(0, dest.indexOf("Province"));
            String destii = desti.replaceAll(' ', '');
            if (exped.indexOf(destii) != -1) {
              print("meme wilaya");
              return 1;
            } else {
              print("Wilaya differente");
              return 0;
            }
          } else {
            return 0;
          }
        }
      }
    }
    return null;
  }
}
