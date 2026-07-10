import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'
    as http;

import '../models/dashboard_admin_model.dart';

import '../services/api_service.dart';

class DashboardAdminViewModel
    extends ChangeNotifier {

  bool isLoading = false;

  DashboardAdminModel?
      dashboardData;

  Future<void> getDashboard()
  async {

    isLoading = true;

    notifyListeners();

    try {

      final response =
          await http.get(

        Uri.parse(

          "${ApiService.baseUrl}/dashboard_admin.php",
        ),
      );

      final data =
          jsonDecode(response.body);

      if (data["status"] ==
          "success") {

        dashboardData =
            DashboardAdminModel
                .fromJson(

          data["data"],
        );
      }

    } catch (e) {

      debugPrint(e.toString());
    }

    isLoading = false;

    notifyListeners();
  }
}