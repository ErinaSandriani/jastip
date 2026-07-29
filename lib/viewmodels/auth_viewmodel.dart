import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;

  String message = "";

  String userRole = "";

  // DATA USER LOGIN
  int? userId;

  String namaUser = "";

  String emailUser = "";

  String noHpUser = "";

  Future<bool> login(
    String email,
    String password,
  ) async {
    isLoading = true;

    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(
          "${ApiService.baseUrl}/login.php",
        ),
        body: {
          "email": email,
          "password": password,
        },
      );

      print("LOGIN RESPONSE:");
      print(response.body);

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        userRole =
            data["role"] ??
                "customer";

        if (data["user"] != null) {
          userId = int.tryParse(
            data["user"]["id"].toString(),
          );

          namaUser =
              data["user"]["nama"] ?? "";

          emailUser =
              data["user"]["email"] ??
                  email;
          
          noHpUser =
              data["user"]["no_hp"] ?? "";
        }

        final prefs = await SharedPreferences.getInstance();

await prefs.setInt("userId", userId!);

await prefs.setString("namaUser", namaUser);

await prefs.setString("emailUser", emailUser);

await prefs.setString("noHpUser", noHpUser);

await prefs.setString("userRole", userRole);

message = "Login berhasil";

return true;
      } else {
        message =
            data["message"] ??
                "Login gagal";

        return false;
      }
    } catch (e) {
      print("ERROR LOGIN:");
      print(e);

      message = "Terjadi kesalahan";

      return false;
    } finally {
  isLoading = false;
  notifyListeners();
}
  }

Future<bool> loadSession() async {

  final prefs = await SharedPreferences.getInstance();

  final id = prefs.getInt("userId");

  if (id == null) return false;

  userId = id;
  namaUser = prefs.getString("namaUser") ?? "";
  emailUser = prefs.getString("emailUser") ?? "";
  noHpUser = prefs.getString("noHpUser") ?? "";
  userRole = prefs.getString("userRole") ?? "";

  notifyListeners();

  return true;
}

  Future<bool> register(
    String nama,
    String email,
    String password,
  ) async {
    isLoading = true;

    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(
          "${ApiService.baseUrl}/register.php",
        ),
        body: {
          "nama": nama,
          "email": email,
          "password": password,
        },
      );

      print("REGISTER RESPONSE:");
      print(response.body);

      final data = jsonDecode(response.body);

      isLoading = false;

      notifyListeners();

      if (data["status"] == "success") {
        message =
            "Register berhasil";

        return true;
      } else {
        message =
            data["message"] ??
                "Register gagal";

        return false;
      }
    } catch (e) {
      print("ERROR REGISTER:");
      print(e);

      isLoading = false;

      message = "Terjadi kesalahan";

      notifyListeners();

      return false;
    }
  }

  Future<bool> updateProfile({

  required String nama,

  required String noHp,

}) async {

  if (userId == null) return false;

  try {

    final result =
        await ApiService.updateProfile(

      userId: userId!,

      nama: nama,

      noHp: noHp,

    );

    if (result["status"] == "success") {

      namaUser = nama;

      noHpUser = noHp;

      notifyListeners();

      return true;
    }

  } catch (e) {

    debugPrint(e.toString());

  }

  return false;
}

  // ======================
  // LOGOUT
  // ======================

  Future<void> logout() async {

    final prefs = await SharedPreferences.getInstance();

await prefs.clear();
    userId = null;
    namaUser = "";
    emailUser = "";
    noHpUser = "";
    userRole = "";
    message = "";

    notifyListeners();
  }
}