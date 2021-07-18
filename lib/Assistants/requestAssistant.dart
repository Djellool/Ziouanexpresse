import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssistant {
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodedata = jsonDecode(jsonData);
        return decodedata;
      } else {
        print("Response = " + response.statusCode.toString());
        return "Failed";
      }
    } catch (exp) {
      return "Failed";
    }
  }
}
