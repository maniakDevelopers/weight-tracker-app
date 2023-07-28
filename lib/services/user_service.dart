import 'dart:convert';
import 'package:weight_tracker_app/common/packages.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<ResponseModel> signup(email, password) async {
    var requestBody = {"email": email, "password": password};

    var response = await http.post(Uri.parse(Config.registerEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));

    var jsonResponse = jsonDecode(response.body);

    return ResponseModel(jsonResponse["status"], jsonResponse["data"]);
  }

  static Future<ResponseModel> login(email, password) async {
    var requestBody = {"email": email, "password": password};

    var response = await http.post(Uri.parse(Config.loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));

    var jsonResponse = jsonDecode(response.body);

    return ResponseModel(jsonResponse["status"], jsonResponse["token"]);
  }
}
