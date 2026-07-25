import 'package:flutter/material.dart';

import '../models/rekening_model.dart';
import '../services/api_service.dart';

class RekeningViewModel extends ChangeNotifier {

  bool isLoading = false;

  List<RekeningModel> rekening = [];

  Future<void> getRekening() async {

    isLoading = true;
    notifyListeners();

    try {

      final data = await ApiService.getRekening();

      if (data["status"] == "success") {

        rekening = (data["data"] as List)
            .map((e) => RekeningModel.fromJson(e))
            .toList();

      }

    } catch (e) {

      debugPrint(e.toString());

    }

    isLoading = false;
    notifyListeners();

  }

  Future<bool> tambahRekening({
    required String metodePembayaran,
    required String nomorRekening,
    required String atasNama,
  }) async {

    try {

      final response = await ApiService.tambahRekening(
        metodePembayaran: metodePembayaran,
        nomorRekening: nomorRekening,
        atasNama: atasNama,
      );

      if (response["status"] == "success") {

        await getRekening();

        return true;

      }

    } catch (e) {

      debugPrint(e.toString());

    }

    return false;

  }

  Future<bool> updateRekening({
    required int id,
    required String metodePembayaran,
    required String nomorRekening,
    required String atasNama,
  }) async {

    try {

      final response = await ApiService.updateRekening(
        id: id,
        metodePembayaran: metodePembayaran,
        nomorRekening: nomorRekening,
        atasNama: atasNama,
      );

      if (response["status"] == "success") {

        await getRekening();

        return true;

      }

    } catch (e) {

      debugPrint(e.toString());

    }

    return false;

  }

  Future<bool> deleteRekening(int id) async {

    try {

      final response = await ApiService.deleteRekening(id);

      if (response["status"] == "success") {

        await getRekening();

        return true;

      }

    } catch (e) {

      debugPrint(e.toString());

    }

    return false;

  }

}