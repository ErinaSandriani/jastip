import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/notification_model.dart';
import '../services/api_service.dart';

class NotificationViewModel extends ChangeNotifier {

  bool isLoading = false;

  List<NotificationModel> notifications = [];

  Future<void> getNotifications(
    int userId,
  ) async {

    isLoading = true;
    notifyListeners();

    try {

      final response = await http.get(

        Uri.parse(
          "${ApiService.baseUrl}/get_notifications.php?user_id=$userId",
        ),
      );

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {

        notifications =
            (data["data"] as List)
                .map(
                  (e) =>
                      NotificationModel.fromJson(e),
                )
                .toList();
      }

    } catch (e) {

      debugPrint(e.toString());

    }

    isLoading = false;
    notifyListeners();
  }
}