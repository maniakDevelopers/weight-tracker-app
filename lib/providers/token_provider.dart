import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TokenProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  void getToken(String setToken) {
    _token = setToken;
    notifyListeners();
  }
}
