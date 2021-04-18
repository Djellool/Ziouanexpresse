import 'package:geolocator/geolocator.dart';
import 'package:ziouanexpress/Assistants/requestAssistant.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAdress(Position position) async {
    String placeAdress = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyC10dTdJKvGn8IyB8kMbm4ZLEAUkegfsEs";
    var response = await RequestAssistant.getRequest(url);
    if (response != "Failed") {
      placeAdress = response["results"]["0"]["formatted_adress"];
    }
    return placeAdress;
  }
}
