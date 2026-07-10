class TravelerModel {
  final int id;
  final String nama;
  final String email;
  final String tanggalPulang;

  TravelerModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.tanggalPulang,
  });

  factory TravelerModel.fromJson(
      Map<String, dynamic> json) {
    return TravelerModel(
      id: int.parse(json["id"].toString()),
      nama: json["nama"] ?? "",
      email: json["email"] ?? "",
      tanggalPulang:
          json["tanggal_pulang"] ?? "",
    );
  }
}