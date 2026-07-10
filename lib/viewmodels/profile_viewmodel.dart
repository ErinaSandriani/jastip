import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'
    as http;

import '../models/profile_model.dart';

import '../services/api_service.dart';

class ProfileViewModel
    extends ChangeNotifier {

  bool isLoading = false;

  ProfileModel? profile;

  Future<void> getProfile(
    int userId,
  ) async {

    isLoading = true;

    notifyListeners();

    try {

      final response =
          await http.get(

        Uri.parse(

          "${ApiService.baseUrl}/get_profile.php?user_id=$userId",
        ),
      );

      final data =
          jsonDecode(response.body);

      if (data["status"] ==
          "success") {

        profile =
            ProfileModel.fromJson(

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