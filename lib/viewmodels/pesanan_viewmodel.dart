import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/pesanan_model.dart';
import '../services/api_service.dart';

class PesananViewModel extends ChangeNotifier {
  bool isLoading = false;

  int nominalDp = 0;

  List<Pesanan> pesananList = [];

  // USER LOGIN SAAT INI
int? currentUserId;

  // ======================
  // GET PESANAN
  // ======================
  Future<void> getPesanan({int? userId}) async {
  isLoading = true;
  notifyListeners();

  try {
    String url = "${ApiService.baseUrl}/get_orders.php";

    if (userId != null) {
      url += "?user_id=$userId";
    }

    final response = await http.get(
      Uri.parse(url),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == "success") {
      pesananList = (data["data"] as List)
          .map((item) => Pesanan.fromJson(item))
          .toList();
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  isLoading = false;
  notifyListeners();
}

  Future<void> getPesananTraveler(int travelerId) async {
  isLoading = true;
  notifyListeners();

  try {
    final response = await http.get(
      Uri.parse(
        "${ApiService.baseUrl}/get_orders.php?traveler_id=$travelerId",
      ),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == "success") {
      pesananList = (data["data"] as List)
          .map((item) => Pesanan.fromJson(item))
          .toList();
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  isLoading = false;
  notifyListeners();
}

  // ======================
  // CREATE ORDER (return bool)
  // ======================
  Future<bool> createOrder({
    required String kategori,
    required String namaLengkap,
    required String nomorTelepon,
    required String provinsi,
    required String kota,
    required String kodePos,
    required String alamat,
    required String notes,
    required int travelerId,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("${ApiService.baseUrl}/create_order.php"),
        body: {
         "user_id": currentUserId.toString(),
         "traveler_id": travelerId.toString(),
        "kategori": kategori,
         "nama_penerima": namaLengkap,
         "nomor_hp": nomorTelepon,
         "alamat": "$alamat, $kota, $provinsi, $kodePos",
         "notes": notes,
        },
      );

      debugPrint(response.body);

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        nominalDp = data["nominal_dp"] ?? 0;

        isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
    return false;
  }

  // ======================
  // CREATE ORDER GET ID
  // ======================
  Future<int?> createOrderGetId({
    required String kategori,
    required String namaLengkap,
    required String nomorTelepon,
    required String provinsi,
    required String kota,
    required String kodePos,
    required String alamat,
    required String notes,
    required int travelerId,
  }) async {
    try {
      debugPrint("===== CREATE ORDER =====");
  debugPrint("currentUserId = $currentUserId");
  debugPrint("travelerId = $travelerId");
  debugPrint("kategori = $kategori");
  debugPrint("namaLengkap = $namaLengkap");
  debugPrint("nomorTelepon = $nomorTelepon");
  debugPrint("alamat = $alamat, $kota, $provinsi, $kodePos");
  debugPrint("notes = $notes"); 
  
      final response = await http.post(
        Uri.parse("${ApiService.baseUrl}/create_order.php"),
        body: {
          "user_id": currentUserId.toString(),
          "traveler_id": travelerId.toString(),
          "kategori": kategori,
          "nama_penerima": namaLengkap,
          "nomor_hp": nomorTelepon,
          "alamat": "$alamat, $kota, $provinsi, $kodePos",
          "notes": notes,
        },
      );

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        return int.parse(data["order_id"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }

  // ======================
  // UPLOAD DP 
  // ======================
  Future<bool> uploadDp({
    required int orderId,
    required File image,
  }) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${ApiService.baseUrl}/upload_dp.php"),
      );

      request.fields["order_id"] = orderId.toString();

      request.files.add(
        await http.MultipartFile.fromPath(
          "image",
          image.path,
        ),
      );

      final streamedResponse = await request.send();
      final responseBody =
          await streamedResponse.stream.bytesToString();

      debugPrint("UPLOAD DP RESPONSE: $responseBody");

      final data = jsonDecode(responseBody);

      if (data["status"] == "success") {
        return true;
      } else {
        debugPrint("UPLOAD FAILED: ${data["message"]}");
        return false;
      }
    } catch (e) {
      debugPrint("UPLOAD EXCEPTION: $e");
      return false;
    }
  }

  // ======================
// UPLOAD PELUNASAN
// ======================
Future<bool> uploadPelunasan({
  required int orderId,
  required File image,
}) async {
  try {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        "${ApiService.baseUrl}/upload_pelunasan.php",
      ),
    );

    request.fields["order_id"] =
        orderId.toString();

    request.files.add(
      await http.MultipartFile.fromPath(
        "image",
        image.path,
      ),
    );

    final streamedResponse =
        await request.send();

    final responseBody =
        await streamedResponse.stream.bytesToString();

    debugPrint(
      "UPLOAD PELUNASAN RESPONSE: $responseBody",
    );

    final data = jsonDecode(responseBody);

    if (data["status"] == "success") {
      await getPesanan(); // refresh list
      return true;
    } else {
      debugPrint(
        "UPLOAD PELUNASAN FAILED: ${data["message"]}",
      );
      return false;
    }
  } catch (e) {
    debugPrint(
      "UPLOAD PELUNASAN ERROR: $e",
    );
    return false;
  }
}

  // ======================
// UPDATE STATUS
// ======================
Future<bool> updateStatus(
  int orderId,
  String status,
) async {
  try {
    final response = await http.post(
      Uri.parse(
        "${ApiService.baseUrl}/update_status.php",
      ),
      body: {
        "order_id": orderId.toString(),
        "status": status,
      },
    );

    final data = jsonDecode(response.body);

    if (data["status"] == "success") {
      await getPesanan();
      return true;
    }

    return false;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

// ==========================
  // Reminder Pelunasan
  // ==========================

  List<Pesanan> get reminderPesanan {

  return pesananList.where((pesanan) {

    if (pesanan.status != "Menunggu Pelunasan") {
      return false;
    }

    if (pesanan.deadlinePelunasan.isEmpty) {
      return false;
    }

    final sisaHari = getSisaHari(
      pesanan.deadlinePelunasan,
    );

    return sisaHari <= 3;

  }).toList();
}

int getSisaHari(String deadline) {

  if (deadline.isEmpty) {
    return 999;
  }

  final batas = DateTime.parse(deadline);

  return batas.difference(DateTime.now()).inDays;
}

  // ======================
  // ASSIGN TRAVELER
  // ======================
  Future<void> assignTraveler({
    required int orderId,
    required int travelerId,
  }) async {
    try {
      await http.post(
        Uri.parse("${ApiService.baseUrl}/assign_traveler.php"),
        body: {
          "order_id": orderId.toString(),
          "traveler_id": travelerId.toString(),
        },
      );

      await getPesanan();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}