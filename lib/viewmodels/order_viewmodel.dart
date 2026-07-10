import 'package:flutter/material.dart';

import '../services/order_service.dart';

class OrderViewModel extends ChangeNotifier {

  final OrderService _orderService = OrderService();

  bool isLoading = false;

  // ================= CREATE ORDER =================

  Future<Map<String, dynamic>> createOrder({

    required int userId,
    required int travelerId,
    required String kategori,
    required String notes,
    required String alamat,

  }) async {

    isLoading = true;
    notifyListeners();

    try {

      final result = await _orderService.createOrder(

        userId: userId,
        travelerId: travelerId,
        kategori: kategori,
        notes: notes,
        alamat: alamat,

      );

      isLoading = false;
      notifyListeners();

      return result;

    } catch (e) {

      isLoading = false;
      notifyListeners();

      return {
        "status": "error",
        "message": e.toString(),
      };
    }
  }

  // ================= UPDATE STATUS =================

  Future<Map<String, dynamic>> updateStatus({

    required int orderId,
    required String status,
    required String keterangan,

  }) async {

    isLoading = true;
    notifyListeners();

    try {

      final result = await _orderService.updateStatus(

        orderId: orderId,
        status: status,
        keterangan: keterangan,

      );

      isLoading = false;
      notifyListeners();

      return result;

    } catch (e) {

      isLoading = false;
      notifyListeners();

      return {
        "status": "error",
        "message": e.toString(),
      };
    }
  }

  // ================= UPLOAD DP =================

  Future<Map<String, dynamic>> uploadDP({

    required int orderId,
    required String dpBukti,

  }) async {

    isLoading = true;
    notifyListeners();

    try {

      final result = await _orderService.uploadDP(

        orderId: orderId,
        dpBukti: dpBukti,

      );

      isLoading = false;
      notifyListeners();

      return result;

    } catch (e) {

      isLoading = false;
      notifyListeners();

      return {
        "status": "error",
        "message": e.toString(),
      };
    }
  }

  // ================= UPLOAD PELUNASAN =================

  Future<Map<String, dynamic>> uploadPelunasan({

    required int orderId,
    required String bukti,

  }) async {

    isLoading = true;
    notifyListeners();

    try {

      final result = await _orderService.uploadPelunasan(

        orderId: orderId,
        bukti: bukti,

      );

      isLoading = false;
      notifyListeners();

      return result;

    } catch (e) {

      isLoading = false;
      notifyListeners();

      return {
        "status": "error",
        "message": e.toString(),
      };
    }
  }
}