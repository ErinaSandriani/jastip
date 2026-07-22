class Pesanan {

  final int id;

  final String namaBarang;

  final String kategori;

  final String alamat;

  final String notes;

  final String status;

  final String customerNama;

  final String namaTraveler;

  final String tanggalKepulangan;

  final String dpBukti;

  final String pelunasanBukti;

  final int hargaBarang;

  final int feeJastip;

  final int ongkirIndonesia;

  final int totalBayar;

  final int nominalDp;

  final String deadlinePelunasan;

  Pesanan({

    required this.id,

    required this.namaBarang,

    required this.kategori,

    required this.alamat,

    required this.notes,

    required this.status,

    required this.customerNama,

    required this.namaTraveler,

    required this.tanggalKepulangan,

    required this.dpBukti,

    required this.pelunasanBukti,

    required this.hargaBarang,

    required this.feeJastip,

    required this.ongkirIndonesia,

    required this.totalBayar,

    required this.nominalDp,

    required this.deadlinePelunasan,
  });

  factory Pesanan.fromJson(

    Map<String, dynamic> json,
  ) {

    return Pesanan(

      id: int.parse(
        json['id'].toString(),
      ),

      namaBarang:
          json['nama_barang'] ??
              "",

      kategori:
          json['kategori'] ??
              "",

      alamat:
          json['alamat'] ??
              "",

      notes:
          json['notes'] ??
              "",

      status:
          json['status'] ??
              "",

      customerNama:
          json['customer_nama'] ??
              "",

      namaTraveler:
          json['nama_traveler'] ??
              "",

      tanggalKepulangan:
          json['tanggal_kepulangan'] ??
              "",

      dpBukti:
          json['dp_bukti'] ?? 
              "",

      pelunasanBukti:
    json['pelunasan_bukti'] ?? 
    "",

      hargaBarang: int.tryParse(json['harga_barang'].toString()) ?? 0,

      feeJastip: int.tryParse(json['fee_jastip'].toString()) ?? 0,

      ongkirIndonesia:
    int.tryParse(json['ongkir_indonesia'].toString()) ?? 0,

      totalBayar:
    int.tryParse(json['total_bayar'].toString()) ?? 0,

      nominalDp:
    int.tryParse(json['nominal_dp'].toString()) ?? 0,

      deadlinePelunasan:
          json['deadline_pelunasan'] ?? 
              "",
    );
  }
}