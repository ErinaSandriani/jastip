class TravelerModel {

  final int id;

  final String nama;

  final String email;

  final String noHp;

  final String alamat;

  final String tanggalPulang;

  final String statusVerifikasi;

  TravelerModel({

    required this.id,

    required this.nama,

    required this.email,

    required this.noHp,

    required this.alamat,

    required this.tanggalPulang,

    required this.statusVerifikasi,
  });

  factory TravelerModel.fromJson(
      Map<String, dynamic> json) {

    return TravelerModel(

      id: int.parse(
        json["id"].toString(),
      ),

      nama: json["nama"] ?? "",

      email: json["email"] ?? "",

      noHp: json["no_hp"] ?? "",

      alamat: json["alamat"] ?? "",

      tanggalPulang:
          json["tanggal_pulang"] ?? "",

      statusVerifikasi:
          json["status_verifikasi"] ?? "pending",
    );
  }
}