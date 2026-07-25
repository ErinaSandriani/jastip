class RekeningModel {
  final int id;
  final String metodePembayaran;
  final String nomorRekening;
  final String atasNama;

  RekeningModel({
    required this.id,
    required this.metodePembayaran,
    required this.nomorRekening,
    required this.atasNama,
  });

  factory RekeningModel.fromJson(Map<String, dynamic> json) {
    return RekeningModel(
      id: int.parse(json['id'].toString()),
      metodePembayaran: json['metode_pembayaran'],
      nomorRekening: json['nomor_rekening'],
      atasNama: json['atas_nama'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'metode_pembayaran': metodePembayaran,
      'nomor_rekening': nomorRekening,
      'atas_nama': atasNama,
    };
  }
}