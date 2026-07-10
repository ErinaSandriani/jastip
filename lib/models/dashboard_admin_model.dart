class DashboardAdminModel {

  final int totalOrders;

  final int totalCustomer;

  final int totalTraveler;

  final int totalTransaksi;

  DashboardAdminModel({

    required this.totalOrders,

    required this.totalCustomer,

    required this.totalTraveler,

    required this.totalTransaksi,
  });

  factory DashboardAdminModel.fromJson(

    Map<String, dynamic> json,
  ) {

    return DashboardAdminModel(

      totalOrders:
          json["total_orders"] ?? 0,

      totalCustomer:
          json["total_customer"] ?? 0,

      totalTraveler:
          json["total_traveler"] ?? 0,

      totalTransaksi:
          json["total_transaksi"] ?? 0,
    );
  }
}