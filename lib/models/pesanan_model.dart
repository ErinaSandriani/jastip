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
    );
  }
}