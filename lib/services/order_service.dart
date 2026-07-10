import 'dart:convert';

import 'package:http/http.dart' as http;

class OrderService {

  static const String baseUrl = "http://10.0.2.2:8000";

  // ================= CREATE ORDER =================

  Future<Map<String, dynamic>> createOrder({

    required int userId,
    required int travelerId,
    required String kategori,
    required String notes,
    required String alamat,

  }) async {

    final response = await http.post(

      Uri.parse("$baseUrl/create_order.php"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "user_id": userId,
        "traveler_id": travelerId,
        "kategori": kategori,
        "notes": notes,
        "alamat": alamat,

      }),
    );

    return jsonDecode(response.body);
  }

  // ================= UPDATE STATUS =================

  Future<Map<String, dynamic>> updateStatus({

    required int orderId,
    required String status,
    required String keterangan,

  }) async {

    final response = await http.post(

      Uri.parse("$baseUrl/update_status.php"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "order_id": orderId,
        "status": status,
        "keterangan": keterangan,

      }),
    );

    return jsonDecode(response.body);
  }

  // ================= UPLOAD DP =================

  Future<Map<String, dynamic>> uploadDP({

    required int orderId,
    required String dpBukti,

  }) async {

    final response = await http.post(

      Uri.parse("$baseUrl/upload_dp.php"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "order_id": orderId,
        "dp_bukti": dpBukti,

      }),
    );

    return jsonDecode(response.body);
  }

  // ================= UPLOAD PELUNASAN =================

  Future<Map<String, dynamic>> uploadPelunasan({

    required int orderId,
    required String bukti,

  }) async {

    final response = await http.post(

      Uri.parse("$baseUrl/upload_pelunasan.php"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "order_id": orderId,
        "pelunasan_bukti": bukti,

      }),
    );

    return jsonDecode(response.body);
  }
}