import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:yaqiz/alarm_info.dart';
import 'package:yaqiz/api/medel/device.dart';
import 'package:yaqiz/api/medel/user.dart';
import 'package:yaqiz/api/medel/vital.dart';
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

  Future<bool> signup(User user) async {
    final response = await http.post(
        Uri.parse(baseUrl + ApiConstants.signupEndpoint),
        body: jsonEncode(user.toJson()),
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
    Hive.box<AlarmInfo>('alarms')
        .deleteAll(Hive.box<AlarmInfo>('alarms').values.map((e) => e.key));
  }

  Future<User> getUser({int? id}) async {
    final response = await http.get(
        Uri.parse(
            "$baseUrl${ApiConstants.userEndpoint}/${id ?? await AppLocalStorage.getString(AppStorageKey.id)}"),
        headers: {HttpHeaders.contentTypeHeader: contentType});
    if (response.body.isEmpty) {
      throw Exception("get user info error");
    }
    return User.fromJson(json.decode(response.body)[0]);
  }

  Future<List<Device>> getDevices({int? id}) async {
    final response = await http.get(
        Uri.parse(
            "$baseUrl${ApiConstants.deviceEndpoint}/${id ?? await AppLocalStorage.getString(AppStorageKey.id)}"),
        headers: {HttpHeaders.contentTypeHeader: contentType});
    if (response.body.isEmpty) {
      throw Exception("get devices info error");
    }

    return json
        .decode(response.body)
        .map((json) => Device.fromJson(json))
        .toList()
        .cast<Device>();
  }

  Future<Vital> getVital({required int deviceId}) async {
    final response = await http.get(
        Uri.parse("$baseUrl${ApiConstants.signsEndpoint}/$deviceId}"),
        headers: {HttpHeaders.contentTypeHeader: contentType});
    if (response.body.isEmpty) {
      throw Exception("get vital info error");
    }
    return Vital.fromJson(json.decode(response.body));
  }
}
