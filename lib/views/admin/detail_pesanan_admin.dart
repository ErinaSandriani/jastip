import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../services/api_service.dart';

import '../../viewmodels/pesanan_viewmodel.dart';

import '../../models/pesanan_model.dart';

import 'konfirmasi_barang_page.dart';

class DetailPesananAdmin extends StatefulWidget {
  final Pesanan pesanan;

  const DetailPesananAdmin({
    super.key,
    required this.pesanan,
  });

  @override
  State<DetailPesananAdmin> createState() =>
      _DetailPesananAdminState();
}

class _DetailPesananAdminState
    extends State<DetailPesananAdmin> {

  Color getStatusColor(String status) {
  switch (status) {
    case "Menunggu Konfirmasi Admin":
      return Colors.orange;

    case "Diproses":
      return Colors.blue;

    case "On Hold":
      return Colors.deepOrange;

    case "Tidak Ditemukan":
      return Colors.red;

    case "Dalam Pengiriman":
      return Colors.purple;

    case "Menunggu Pelunasan":
      return Colors.teal;

    case "Dikirim ke Rumah Customer":
      return Colors.indigo;

    case "Selesai":
      return Colors.green;

    case "Dibatalkan":
      return Colors.grey;

    default:
      return Colors.grey;
  }
}

  Widget infoTile({

    required IconData icon,

    required String title,

    required String value,

  }){

    return Padding(

      padding: const EdgeInsets.only(bottom:18),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          CircleAvatar(

            radius:20,

            backgroundColor:
                const Color(0xffFDECEC),

            child: Icon(

              icon,

              color:
                  const Color(0xffB71C1C),

              size:20,
            ),
          ),

          const SizedBox(width:14),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: const TextStyle(

                    color: Colors.grey,

                    fontSize:13,
                  ),
                ),

                const SizedBox(height:3),

                Text(

                  value.isEmpty
                      ? "-"

                      : value,

                  style: const TextStyle(

                    fontSize:16,

                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateStatus(String status) async {
  final vm = context.read<PesananViewModel>();

  final success = await vm.updateStatus(
    widget.pesanan.id,
    status,
  );

  if (!mounted) return;

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Status berhasil diubah menjadi $status",
        ),
      ),
    );

    Navigator.pop(context, true);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Gagal mengubah status",
        ),
      ),
    );
  }
}

Future<void> _showConfirmDialog({
  required String title,
  required String message,
  required String nextStatus,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Ya"),
        ),
      ],
    ),
  );

  if (result == true) {
    await _updateStatus(nextStatus);
  }
}

Widget buildActionButton() {
  switch (widget.pesanan.status) {
    case "Menunggu Konfirmasi Admin":
    return Row(
  children: [
    Expanded(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.cancel),
        label: const Text("Batalkan"),
        onPressed: () {
          _showConfirmDialog(
            title: "Batalkan Pesanan",
            message:
                "Yakin ingin membatalkan pesanan ini?",
            nextStatus: "Dibatalkan",
          );
        },
      ),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.check_circle),
        label: const Text("Konfirmasi"),
        onPressed: () {
          _showConfirmDialog(
            title: "Konfirmasi Pesanan",
            message:
                "Konfirmasi pembayaran DP customer?",
            nextStatus: "Diproses",
          );
        },
      ),
    ),
  ],
);

case "Dalam Pengiriman":
return SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.inventory),
    label: const Text(
      "Barang Sudah Sampai",
    ),
    onPressed: () async {

  final result = await Navigator.push(

    context,

    MaterialPageRoute(

      builder: (_) => KonfirmasiBarangPage(
        pesanan: widget.pesanan,
      ),

    ),

  );

  if (result == true) {
    Navigator.pop(context, true);
  }

},
  ),
);

case "Menunggu Pelunasan":
return SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.payments),
    label: const Text(
      "Konfirmasi Pelunasan",
    ),
    onPressed: () {
      _showConfirmDialog(
        title: "Pelunasan",
        message:
            "Customer sudah melakukan pelunasan?",
        nextStatus:
            "Dikirim ke Rumah Customer",
      );
    },
  ),
);

case "Menunggu Verifikasi Pelunasan":
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      icon: const Icon(Icons.verified),
      label: const Text("Verifikasi Pelunasan"),
      onPressed: () {
        _showConfirmDialog(
          title: "Verifikasi Pelunasan",
          message:
              "Apakah bukti pelunasan customer sudah valid?",
          nextStatus: "Dikirim ke Rumah Customer",
        );
      },
    ),
  );

case "Dikirim ke Rumah Customer":
return SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.check),
    label: const Text(
      "Selesaikan Pesanan",
    ),
    onPressed: () {
      _showConfirmDialog(
        title: "Selesaikan Pesanan",
        message:
            "Pesanan sudah diterima customer?",
        nextStatus: "Selesai",
      );
    },
  ),
);

default:
  return const SizedBox.shrink();
}
}

  @override
  Widget build(BuildContext context){

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F5F5),

      appBar: AppBar(

        elevation:0,

        backgroundColor:
            Colors.white,

        foregroundColor:
            Colors.black,

        centerTitle:true,

        title: const Text(

          "Detail Pesanan",

          style: TextStyle(

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              width: double.infinity,

              padding:
                  const EdgeInsets.all(22),

              decoration: BoxDecoration(

                borderRadius:
                    BorderRadius.circular(22),

                gradient:
                    const LinearGradient(

                  colors: [

                    Color(0xffE53935),

                    Color(0xff8E0000),
                  ],
                ),
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(

                    children: [

                      const CircleAvatar(

                        radius:26,

                        backgroundColor:
                            Colors.white,

                        child: Icon(

                          Icons.shopping_bag,

                          color:
                              Color(0xffB71C1C),
                        ),
                      ),

                      const SizedBox(width:14),

                      Expanded(

                        child: Text(

                          widget.pesanan.namaBarang,

                          style:
                              const TextStyle(

                            color:
                                Colors.white,

                            fontSize:22,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height:20),

                  Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal:14,

                      vertical:8,
                    ),

                    decoration: BoxDecoration(

                      color:
                          getStatusColor(
                           widget.pesanan.status,
                          ),

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: Text(

                      widget.pesanan.status,

                      style:
                          const TextStyle(

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

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black.withOpacity(.05),

                    blurRadius: 10,

                    offset:
                        const Offset(0,4),
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Informasi Pesanan",

                    style: TextStyle(

                      fontSize:18,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height:20),

                  infoTile(
  icon: Icons.category,
  title: "Kategori Barang",
  value: widget.pesanan.kategori,
),

                  infoTile(

                    icon: Icons.notes,

                    title: "Detail Barang",

                    value: widget.pesanan.notes,
                  ),

                  infoTile(

                    icon: Icons.person,

                    title: "Customer",

                    value: widget.pesanan.customerNama,
                  ),

                  infoTile(

                    icon: Icons.flight_takeoff,

                    title: "Traveler",

                    value: widget.pesanan.namaTraveler.isEmpty

                        ? "Belum dipilih"

                        : widget.pesanan.namaTraveler,
                  ),

                  infoTile(

                    icon: Icons.calendar_month,

                    title: "Estimasi Kepulangan",

                    value: widget.pesanan.tanggalKepulangan,
                  ),

                  infoTile(

                    icon: Icons.location_on,

                    title: "Alamat Pengiriman",

                    value: widget.pesanan.alamat,
                  ),
                ],
              ),
            ),

            const SizedBox(height:24),

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black.withOpacity(.05),

                    blurRadius:10,

                    offset:
                        const Offset(0,4),
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Bukti Pembayaran DP",

                    style: TextStyle(

                      fontSize:18,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height:18),

                  widget.pesanan.dpBukti.isNotEmpty
                  
    ? ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          "${ApiService.baseUrl}/${widget.pesanan.dpBukti}",
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 220,
              alignment: Alignment.center,
              child: const Text(
                "Gagal memuat gambar",
              ),
            );
          },
        ),
      )
    : Container(
        height: 220,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "Belum ada bukti transfer",
        ),
      ),
                        ],
                      ),
                    ),

            const SizedBox(height:30),
        
        const SizedBox(height: 24),

const Text(
  "Bukti Pelunasan",
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 18),

widget.pesanan.pelunasanBukti.isNotEmpty
    ? ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          "${ApiService.baseUrl}/${widget.pesanan.pelunasanBukti}",
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              height: 220,
              alignment: Alignment.center,
              child: const Text(
                "Gagal memuat gambar",
              ),
            );
          },
        ),
      )
    : Container(
        height: 220,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "Belum ada bukti pelunasan",
        ),
      ),

buildActionButton(),
            const SizedBox(height:20),
          ],
        ),
      ),
    );
  }
}