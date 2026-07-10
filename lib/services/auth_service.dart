import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {

  // Emulator Android
  static const String baseUrl = "http://10.0.2.2:8000";

  // ================= LOGIN =================

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {

    final response = await http.post(

      Uri.parse("$baseUrl/login.php"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  // ================= REGISTER =================

  Future<Map<String, dynamic>> register({

    required String nama,
    required String email,
    required String password,
    required String role,

  }) async {

    final response = await http.post(

      Uri.parse("$baseUrl/register.php"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "nama": nama,
        "email": email,
        "password": password,
        "role": role,

      }),
    );

    return jsonDecode(response.body);
  }
}