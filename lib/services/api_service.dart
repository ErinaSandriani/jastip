import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static String get baseUrl {

    if (kIsWeb) {
      return "http://localhost:8000";
    }

    if (Platform.isAndroid) {
      return "http://192.168.1.8:8000";
    }

    if (Platform.isLinux) {
      return "http://localhost:8000";
    }

    return "http://localhost:8000";
  }

  static Future<Map<String, dynamic>> updatePelunasan({
  required int orderId,
  required int hargaBarang,
  required int feeJastip,
  required int ongkirIndonesia,
  required int totalBayar,
  required String deadlinePelunasan,
}) async {

  final response = await http.post(

    Uri.parse("$baseUrl/update_pelunasan.php"),

    body: {
      "order_id": orderId.toString(),
      "harga_barang": hargaBarang.toString(),
      "fee_jastip": feeJastip.toString(),
      "ongkir_indonesia": ongkirIndonesia.toString(),
      "total_bayar": totalBayar.toString(),
      "deadline_pelunasan": deadlinePelunasan,
    },

  );

  return jsonDecode(response.body);
}

static Future<Map<String, dynamic>> getKategoriDP() async {

  final response = await http.get(
    Uri.parse("$baseUrl/get_kategori_dp.php"),
  );

  return jsonDecode(response.body);
}

static Future<Map<String, dynamic>> updateKategoriDP({
  required int id,
  required int nominalDp,
}) async {

  final response = await http.post(

    Uri.parse("$baseUrl/update_kategori_dp.php"),

    body: {
      "id": id.toString(),
      "nominal_dp": nominalDp.toString(),
    },

  );

  return jsonDecode(response.body);
}

static Future<Map<String, dynamic>> getRekening() async {

  final response = await http.get(
    Uri.parse("$baseUrl/get_rekening.php"),
  );

  return jsonDecode(response.body);

}

static Future<Map<String, dynamic>> tambahRekening({
  required String metodePembayaran,
  required String nomorRekening,
  required String atasNama,
}) async {

  final response = await http.post(

    Uri.parse("$baseUrl/tambah_rekening.php"),

    body: {
      "metode_pembayaran": metodePembayaran,
      "nomor_rekening": nomorRekening,
      "atas_nama": atasNama,
    },

  );

  return jsonDecode(response.body);

}

static Future<Map<String, dynamic>> updateRekening({
  required int id,
  required String metodePembayaran,
  required String nomorRekening,
  required String atasNama,
}) async {

  final response = await http.post(

    Uri.parse("$baseUrl/update_rekening.php"),

    body: {
      "id": id.toString(),
      "metode_pembayaran": metodePembayaran,
      "nomor_rekening": nomorRekening,
      "atas_nama": atasNama,
    },

  );

  return jsonDecode(response.body);

}

static Future<Map<String, dynamic>> deleteRekening(int id) async {

  final response = await http.post(

    Uri.parse("$baseUrl/delete_rekening.php"),

    body: {
      "id": id.toString(),
    },

  );

  return jsonDecode(response.body);

}

static Future<Map<String, dynamic>> updateProfile({
  required int userId,
  required String nama,
  required String noHp,
}) async {

  final response = await http.post(

    Uri.parse("$baseUrl/update_profile.php"),

    body: {

      "id": userId.toString(),

      "nama": nama,

      "no_hp": noHp,
    },

  );

  return jsonDecode(response.body);
}

}