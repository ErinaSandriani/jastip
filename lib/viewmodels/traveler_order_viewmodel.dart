import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'
    as http;

import '../models/pesanan_model.dart';

import '../services/api_service.dart';

class TravelerOrderViewModel
    extends ChangeNotifier {

  List<Pesanan> orders = [];

  bool isLoading = false;

  Future<void> getOrders(

    int travelerId,
  ) async {

    isLoading = true;

    notifyListeners();

    try {

      final response =
          await http.get(

        Uri.parse(

          "${ApiService.baseUrl}/get_orders_by_traveler.php?traveler_id=$travelerId",
        ),
      );

      final data =
          jsonDecode(response.body);

      if (
          data["status"] ==
              "success") {

        orders =

            (data["data"] as List)

                .map(

                  (e) =>
                      Pesanan.fromJson(
                    e,
                  ),
                )

                .toList();
      }

    } catch (e) {

      debugPrint(
        e.toString(),
      );
    }

    isLoading = false;

    notifyListeners();
  }

  Future<void> updateStatus({

    required int orderId,

    required String status,
  }) async {

    await http.post(

      Uri.parse(

        "${ApiService.baseUrl}/update_order_status.php",
      ),

      body: {

        "order_id":
            orderId.toString(),

        "status": status,
      },
    );
  }
}