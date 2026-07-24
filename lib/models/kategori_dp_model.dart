class KategoriDPModel {
  final int id;
  final String kategori;
  final int nominalDp;

  KategoriDPModel({
    required this.id,
    required this.kategori,
    required this.nominalDp,
  });

  factory KategoriDPModel.fromJson(Map<String, dynamic> json) {
    return KategoriDPModel(
      id: int.parse(json['id'].toString()),
      kategori: json['kategori'],
      nominalDp: int.parse(json['nominal_dp'].toString()),
    );
  }
}