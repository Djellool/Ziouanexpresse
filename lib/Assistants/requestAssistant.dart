import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ziouanexpress/Screens/Components/icons_class.dart';

class RequestAssistant {
  static Future<dynamic> getRequest(String Url) async {
    http.Response response = await http.get(Url);
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodedata = jsonDecode(jsonData);
        return decodedata;
      } else {
        return "Failed";
      }
    } catch (exp) {
      return "Failed";
    }
  }
}
