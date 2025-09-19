import 'dart:convert';
import 'package:flutter/services.dart';

class LangService {
  static Future<List<Map<String, dynamic>>> loadOnboarding(String langCode) async {
    final String response =
        await rootBundle.loadString('assets/lang/$langCode.json');
    final data = json.decode(response);
    return List<Map<String, dynamic>>.from(data["onboarding"]);
  }

  static Future<String> loadDialogTitle(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["dialog_title"] as String;
  }

  static Future<String> loadlewati(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["lewati"] as String;
  }

  static Future<String> loadlanjut(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["lanjut"] as String;
  }

  static Future<String> loadselesai(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["selesai"] as String;
  }

  static Future<String> loadlogin(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["login_now"] as String;
  }

  static Future<String> loadguest(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["guest_login"] as String;
  }

  static Future<String> loadlogin_as(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["login_as"] as String;
  }

  static Future<String> input_email(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["input_email"] as String;
  }

  static Future<String> input_password(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["input_password"] as String;
  }

  static Future<String> lupa_password(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["lupa_password"] as String;
  }

  static Future<String> belum(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["belum"] as String;
  }

  static Future<String> daftar(String langCode) async {
    final String response =
        await rootBundle.loadString("assets/lang/$langCode.json");
    final data = json.decode(response);
    return data["daftar"] as String;
  }
}
