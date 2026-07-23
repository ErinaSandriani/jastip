class ReminderAdminModel {
  final int id;

  final String customer;

  final String namaBarang;

  final String deadlinePelunasan;

  final int sisaHari;

  ReminderAdminModel({
    required this.id,
    required this.customer,
    required this.namaBarang,
    required this.deadlinePelunasan,
    required this.sisaHari,
  });

  factory ReminderAdminModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ReminderAdminModel(
      id: int.parse(
        json["id"].toString(),
      ),
      customer:
          json["customer"] ?? "",

      namaBarang:
          json["nama_barang"] ?? "",

      deadlinePelunasan:
          json["deadline_pelunasan"] ??
              "",

      sisaHari: int.parse(
        json["sisa_hari"].toString(),
      ),
    );
  }
}

class DashboardAdminModel {
  final int totalOrders;

  final int totalCustomer;

  final int totalTraveler;

  final int totalTransaksi;

  final int reminderCount;

  final List<ReminderAdminModel>
      reminder;

  DashboardAdminModel({
    required this.totalOrders,
    required this.totalCustomer,
    required this.totalTraveler,
    required this.totalTransaksi,
    required this.reminderCount,
    required this.reminder,
  });

  factory DashboardAdminModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DashboardAdminModel(
      totalOrders:
          json["total_orders"] ?? 0,

      totalCustomer:
          json["total_customer"] ??
              0,

      totalTraveler:
          json["total_traveler"] ??
              0,

      totalTransaksi:
          json["total_transaksi"] ??
              0,

      reminderCount:
          json["reminder_count"] ??
              0,

      reminder:
          (json["reminder"] as List?)
                  ?.map(
                    (e) =>
                        ReminderAdminModel
                            .fromJson(e),
                  )
                  .toList() ??
              [],
    );
  }
}