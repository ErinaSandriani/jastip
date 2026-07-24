import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

      isLoading = false;

      notifyListeners();

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

      isLoading = false;

      message = "Terjadi kesalahan";

      notifyListeners();

      return false;
    }
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

  void logout() {
    userId = null;
    namaUser = "";
    emailUser = "";
    noHpUser = "";
    userRole = "";
    message = "";

    notifyListeners();
  }
}