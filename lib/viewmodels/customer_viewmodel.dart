import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'
    as http;

import '../models/customer_model.dart';

import '../services/api_service.dart';

class CustomerViewModel
    extends ChangeNotifier {

  bool isLoading = false;

  List<CustomerModel>
      customerList = [];

  Future<void> getCustomers()
  async {

    isLoading = true;

    notifyListeners();

    try {

      final response =
          await http.get(

        Uri.parse(

          "${ApiService.baseUrl}/get_customers.php",
        ),
      );

      final data =
          jsonDecode(response.body);

      if (data["status"] ==
          "success") {

        customerList =

            (data["data"] as List)

                .map(

                  (item) =>
                      CustomerModel
                          .fromJson(
                    item,
                  ),
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