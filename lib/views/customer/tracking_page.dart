import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pesanan_model.dart';
import '../../viewmodels/pesanan_viewmodel.dart';

class TrackingPage extends StatefulWidget {
  final Pesanan pesanan;

  const TrackingPage({
    super.key,
    required this.pesanan,
  });

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  File? selectedImage;

  Future<void> pickImage() async {
  try {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;

      case "Menunggu Konfirmasi Admin":
        return Colors.deepOrange;

      case "Diproses":
        return Colors.blue;

      case "On Hold":
        return Colors.amber;

      case "Tidak Ditemukan":
        return Colors.red;

      case "Dalam Pengiriman":
        return Colors.indigo;

      case "Menunggu Pelunasan":
        return Colors.teal;

      case "Menunggu Verifikasi Pelunasan":
        return Colors.cyan;

      case "Dikirim ke Rumah Customer":
        return Colors.purple;

      case "Selesai":
        return Colors.green;

      case "Dibatalkan":
        return Colors.redAccent;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pesanan = widget.pesanan;

    final pesananVM =
        context.watch<PesananViewModel>();

            return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Tracking Pesanan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(.05),
                    blurRadius: 10,
                    offset:
                        const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                
                const Text(
  "Detail Pesanan",
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 16),

                  Row(
                    children: [

                      const CircleAvatar(
                        backgroundColor:
                            Color(0xffFDECEC),
                        child: Icon(
                          Icons.shopping_bag,
                          color:
                              Color(0xffB71C1C),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          pesanan.namaBarang,
                          style:
                              const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Column(
  children: [

    Row(
      children: [
        const Icon(
          Icons.category,
          size: 18,
          color: Colors.black54,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "Kategori : ${pesanan.kategori}",
          ),
        ),
      ],
    ),
  ],
),

                  Row(
                    children: [

                      const Icon(
                        Icons.flight,
                        size: 18,
                        color: Colors.black54,
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          pesanan.namaTraveler,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

Row(
  children: [
    const Icon(
      Icons.person,
      size: 18,
      color: Colors.black54,
    ),
    const SizedBox(width: 8),
    Expanded(
      child: Text(
        "Penerima : ${pesanan.namaPenerima}",
      ),
    ),
  ],
),

const SizedBox(height: 10),

Row(
  children: [
    const Icon(
      Icons.phone,
      size: 18,
      color: Colors.black54,
    ),
    const SizedBox(width: 8),
    Expanded(
      child: Text(
        "No. HP : ${pesanan.nomorHp}",
      ),
    ),
  ],
),

const SizedBox(height: 10),

Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Icon(
      Icons.notes,
      size: 18,
      color: Colors.black54,
    ),
    const SizedBox(width: 8),
    Expanded(
      child: Text(
        "Catatan : ${pesanan.notes.isEmpty ? "-" : pesanan.notes}",
      ),
    ),
  ],
),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      const Icon(
                        Icons.calendar_month,
                        size: 18,
                        color: Colors.black54,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        pesanan.tanggalKepulangan,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: getStatusColor(
                        pesanan.status,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),

                    child: Text(
                      pesanan.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                ],
              ),
            ),

                        const SizedBox(height: 24),

            const Text(
              "Tracking Pesanan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            _trackingItem(
              "Pesanan Dibuat",
              true,
            ),

            _trackingItem(
              "Menunggu Konfirmasi Admin",
              [
                "Menunggu Konfirmasi Admin",
                "Diproses",
                "On Hold",
                "Tidak Ditemukan",
                "Dalam Pengiriman",
                "Menunggu Pelunasan",
                "Menunggu Verifikasi Pelunasan",
                "Dikirim ke Rumah Customer",
                "Selesai",
              ].contains(pesanan.status),
            ),

            _trackingItem(
              "Traveler Berbelanja",
              [
                "Diproses",
                "On Hold",
                "Tidak Ditemukan",
                "Dalam Pengiriman",
                "Menunggu Pelunasan",
                "Menunggu Verifikasi Pelunasan",
                "Dikirim ke Rumah Customer",
                "Selesai",
              ].contains(pesanan.status),
            ),

            _trackingItem(
              "Barang Dalam Pengiriman",
              [
                "Dalam Pengiriman",
                "Menunggu Pelunasan",
                "Menunggu Verifikasi Pelunasan",
                "Dikirim ke Rumah Customer",
                "Selesai",
              ].contains(pesanan.status),
            ),

            _trackingItem(
              "Menunggu Pelunasan",
              [
                "Menunggu Pelunasan",
                "Menunggu Verifikasi Pelunasan",
                "Dikirim ke Rumah Customer",
                "Selesai",
              ].contains(pesanan.status),
            ),

            _trackingItem(
              "Pelunasan Diverifikasi",
              [
                "Dikirim ke Rumah Customer",
                "Selesai",
              ].contains(pesanan.status),
            ),

            _trackingItem(
              "Pesanan Selesai",
              pesanan.status == "Selesai",
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xffB71C1C),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      pesanan.alamat,
                    ),
                  ),
                ],
              ),
            ),

                        const SizedBox(height: 25),

            if (pesanan.status == "Menunggu Pelunasan" ||
                pesanan.status ==
                    "Menunggu Verifikasi Pelunasan" ||
                pesanan.status ==
                    "Dikirim ke Rumah Customer" ||
                pesanan.status == "Selesai")
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Rincian Pelunasan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const Divider(height: 25),

                    _itemBiaya(
                      "Harga Barang",
                      pesanan.hargaBarang,
                    ),

                    _itemBiaya(
                      "Fee Jastip",
                      pesanan.feeJastip,
                    ),

                    _itemBiaya(
                      "Ongkir Indonesia",
                      pesanan.ongkirIndonesia,
                    ),

                    const Divider(),

                    _itemBiaya(
                      "Total",
                      pesanan.totalBayar,
                      bold: true,
                    ),

                    _itemBiaya(
                      "DP",
                      pesanan.nominalDp,
                    ),

                    const Divider(),

                    _itemBiaya(
                      "Sisa Pelunasan",
                      pesanan.totalBayar -
                          pesanan.nominalDp,
                      bold: true,
                    ),

                    if (pesanan.status ==
                        "Menunggu Pelunasan") ...[

                      const SizedBox(height: 25),

                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Colors.grey.shade300,
                            ),
                            borderRadius:
                                BorderRadius.circular(
                                    16),
                          ),
                          child: selectedImage == null
                              ? const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      size: 50,
                                      color: Color(
                                          0xffB71C1C),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Tap untuk memilih bukti pelunasan",
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(
                                          16),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(
                                    0xffB71C1C),
                            foregroundColor:
                                Colors.white,
                          ),
                          onPressed: () async {
                            if (selectedImage ==
                                null) {
                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Pilih bukti transfer terlebih dahulu",
                                  ),
                                ),
                              );
                              return;
                            }

                            final success =
                                await pesananVM
                                    .uploadPelunasan(
                              orderId: pesanan.id,
                              image:
                                  selectedImage!,
                            );

                            if (!mounted) return;

                            if (success) {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    AlertDialog(
                                  title: const Text(
                                      "Berhasil"),
                                  content:
                                      const Text(
                                    "Bukti pelunasan berhasil dikirim.\nAdmin akan melakukan verifikasi pembayaran.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context);
                                        Navigator.pop(
                                            context,
                                            true);
                                      },
                                      child:
                                          const Text(
                                              "OK"),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Upload gagal"),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Upload Bukti Pelunasan",
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

                        ],
        ),
      ),
    );
  }

  Widget _trackingItem(
    String title,
    bool active,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            radius: 14,
            backgroundColor: active
                ? const Color(0xffB71C1C)
                : Colors.grey.shade300,
            child: Icon(
              active
                  ? Icons.check
                  : Icons.circle,
              size: 14,
              color: Colors.white,
            ),
          ),

          Container(
            width: 2,
            height: 40,
            margin:
                const EdgeInsets.symmetric(
              horizontal: 13,
            ),
            color: active
                ? const Color(0xffB71C1C)
                : Colors.grey.shade300,
          ),

          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(
                top: 4,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: active
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: active
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemBiaya(
    String title,
    num value, {
    bool bold = false,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [

          Text(
            title,
            style: TextStyle(
              fontWeight: bold
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),

          Text(
            "Rp ${value.toString()}",
            style: TextStyle(
              fontWeight: bold
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}