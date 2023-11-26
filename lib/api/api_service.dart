import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yaqiz/constant.dart';
import 'package:yaqiz/shared_preferences.dart';

class ApiService {
  final String contentType = "application/json";
  final baseUrl = ApiConstants.androidBaseUrl;

  Future<void> login(String email, String password) async {
    final response = await http.post(
        Uri.parse(baseUrl + ApiConstants.loginEndpoint),
        body: jsonEncode({"email": email, "password": password}),
        headers: {HttpHeaders.contentTypeHeader: contentType});
    if (response.body.isEmpty) {
      throw Exception("login error");
    }
    await AppLocalStorage.setString(
        AppStorageKey.id, json.decode(response.body)['Employee_ID'].toString());
    await AppLocalStorage.setBool(
        AppStorageKey.admin, json.decode(response.body)['isAdmin'] != 0);
  }
}
