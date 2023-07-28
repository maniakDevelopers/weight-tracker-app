import 'dart:convert';
import 'package:weight_tracker_app/common/packages.dart';
import 'package:http/http.dart' as http;

class WeightService {
  static Future<ResponseModel> saveWeight(userId, weight, weighed_on) async {
    var requestBody = {
      "userId": userId,
      "weight": weight,
      "weighed_on": weighed_on,
    };

    var response = await http.post(Uri.parse(Config.saveWeightEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));

    var jsonResponse = jsonDecode(response.body);

    return ResponseModel(jsonResponse["status"], jsonResponse["data"]);
  }

  static Future<ResponseModel> getWeightHistory(userId) async {
    var requestBody = {
      "userId": userId,
    };

    var response = await http.post(Uri.parse(Config.weightHistoryEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));

    var jsonResponse = jsonDecode(response.body);
    return ResponseModel(jsonResponse["status"], jsonResponse["data"]);
  }

  static Future<ResponseModel> deleteWeight(String weightId) async {
    var requestBody = {
      "id": weightId,
    };

    var response = await http.post(Uri.parse(Config.deleteEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));

    var jsonResponse = jsonDecode(response.body);
    return ResponseModel(jsonResponse["status"], jsonResponse["data"]);
  }
}
