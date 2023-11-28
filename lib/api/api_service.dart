import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yaqiz/constant.dart';
import 'package:yaqiz/shared_preferences.dart';

class ApiService {
  final String contentType = "application/json";
  final baseUrl = ApiConstants.androidBaseUrl;

  Future<bool> login(String id, String password) async {
    final response = await http.post(
        Uri.parse(baseUrl + ApiConstants.loginEndpoint),
        body: jsonEncode({"id": id, "password": password}),
        headers: {HttpHeaders.contentTypeHeader: contentType});
    if (response.body.isEmpty) {
      throw Exception("login error");
    }
    await AppLocalStorage.setString(
        AppStorageKey.id, json.decode(response.body)['Employee_ID'].toString());
    await AppLocalStorage.setBool(
        AppStorageKey.supervisor, json.decode(response.body)['isAdmin'] != 0);
    return (await AppLocalStorage.getBool(AppStorageKey.supervisor))!;
  }

  Future<void> logout() async {
    await AppLocalStorage.delete(AppStorageKey.id);
    await AppLocalStorage.delete(AppStorageKey.supervisor);
  }
}
