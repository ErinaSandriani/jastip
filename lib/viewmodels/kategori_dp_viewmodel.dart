import 'package:flutter/material.dart';

import '../models/kategori_dp_model.dart';
import '../services/api_service.dart';

class KategoriDPViewModel extends ChangeNotifier {

  bool isLoading = false;

  List<KategoriDPModel> kategoriDP = [];

  Future<void> getKategoriDP() async {

    isLoading = true;
    notifyListeners();

    try {

      final data = await ApiService.getKategoriDP();

if (data["status"] == "success") {
  kategoriDP = (data["data"] as List)
      .map((e) => KategoriDPModel.fromJson(e))
      .toList();
}

    } catch (e) {

      debugPrint(e.toString());

    }

    isLoading = false;
    notifyListeners();

  }

  Future<bool> updateKategoriDP({
    required int id,
    required int nominalDp,
  }) async {

    try {

      final response = await ApiService.updateKategoriDP(
        id: id,
        nominalDp: nominalDp,
      );

      if (response["status"] == "success") {

        await getKategoriDP();

        return true;

      }

    } catch (e) {

      debugPrint(e.toString());

    }

    return false;

  }

}