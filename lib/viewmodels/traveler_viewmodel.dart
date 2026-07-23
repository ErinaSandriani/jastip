import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/traveler_model.dart';
import '../services/api_service.dart';

class TravelerViewModel extends ChangeNotifier {
  bool isLoading = false;

  List<TravelerModel> travelerList = [];

  TravelerModel? profileTraveler;

  Future<void> getAllTravelers() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
          "${ApiService.baseUrl}/get_all_travelers.php",
        ),
      );

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        travelerList = (data["data"] as List)
            .map(
              (e) => TravelerModel.fromJson(e),
            )
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> updateReturnDate({
    required int travelerId,
    required DateTime date,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "${ApiService.baseUrl}/update_return_date.php",
        ),
        body: {
          "traveler_id": travelerId.toString(),
          "tanggal_pulang":
              date.toIso8601String().split("T").first,
        },
      );

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        await getTravelerById(travelerId);
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<void> getTravelerById(int travelerId) async {
  isLoading = true;
  notifyListeners();

  try {
    final response = await http.get(
      Uri.parse(
        "${ApiService.baseUrl}/get_all_travelers.php",
      ),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == "success") {
      travelerList = (data["data"] as List)
          .map((e) => TravelerModel.fromJson(e))
          .toList();

      profileTraveler = travelerList.firstWhere(
        (e) => e.id == travelerId,
      );
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  isLoading = false;
  notifyListeners();
}

  Future<bool> deleteReturnDate(
    int travelerId,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          "${ApiService.baseUrl}/delete_return_date.php",
        ),
        body: {
          "traveler_id": travelerId.toString(),
        },
      );

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        await getTravelerById(travelerId);
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }
  Future<bool> approveTraveler(
  int travelerId,
) async {

  try {

    final response = await http.post(

      Uri.parse(
        "${ApiService.baseUrl}/approve_traveler.php",
      ),

      body: {

        "id": travelerId.toString(),
      },
    );

    final data = jsonDecode(response.body);

    if(data["status"]=="success"){

      await getAllTravelers();

      return true;
    }

  } catch(e){

    debugPrint(e.toString());

  }

  return false;
}

Future<bool> rejectTraveler(
  int travelerId,
) async {

  try {

    final response = await http.post(

      Uri.parse(
        "${ApiService.baseUrl}/reject_traveler.php",
      ),

      body: {

        "id": travelerId.toString(),
      },
    );

    final data = jsonDecode(response.body);

    if(data["status"]=="success"){

      await getAllTravelers();

      return true;
    }

  } catch(e){

    debugPrint(e.toString());

  }

  return false;
}
}