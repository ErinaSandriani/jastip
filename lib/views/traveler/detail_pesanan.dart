import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../viewmodels/pesanan_viewmodel.dart';

import '../../models/pesanan_model.dart';

class DetailPesananPage extends StatefulWidget {
  final Pesanan pesanan;

  const DetailPesananPage({
    super.key,
    required this.pesanan,
  });

  @override
  State<DetailPesananPage> createState() =>
      _DetailPesananPageState();
}

class _DetailPesananPageState
    extends State<DetailPesananPage> {

  Color getStatusColor(String status) {
  switch (status) {

    case "Diproses":
      return Colors.blue;

    case "On Hold":
      return Colors.deepOrange;

    case "Tidak Ditemukan":
      return Colors.red;

    case "Dalam Pengiriman":
      return Colors.purple;

    default:
      return Colors.grey;
  }
}

late String selectedStatus;

final List<String> statusList = [
  "Diproses",
  "On Hold",
  "Tidak Ditemukan",
  "Dalam Pengiriman",
];

@override
void initState() {
  super.initState();

  selectedStatus = statusList.contains(widget.pesanan.status)
    ? widget.pesanan.status
    : statusList.first;
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

        title: const Text(

          "Update Pesanan",

          style: TextStyle(

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

  padding: const EdgeInsets.all(20),

  child: Column(

    children: [

      Container(

        width: double.infinity,

        padding: const EdgeInsets.all(22),

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(22),

          gradient: const LinearGradient(

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

            colors: [

              Color(0xffE53935),

              Color(0xffB71C1C),

            ],
          ),
        ),

        child: Row(

          children: [

            const CircleAvatar(

              radius: 30,

              backgroundColor: Colors.white,

              child: Icon(

                Icons.shopping_bag,

                size: 30,

                color: Color(0xffB71C1C),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(

                    widget.pesanan.namaBarang,

                    style: const TextStyle(

                      color: Colors.white,

                      fontSize: 22,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(

                    widget.pesanan.kategori,

                    style: const TextStyle(

                      color: Colors.white70,

                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 22),

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

                fontSize: 18,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            Row(

              children: [

                const Text(

                  "Status",

                  style: TextStyle(

                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const Spacer(),

                Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 14,

                    vertical: 7,
                  ),

                  decoration: BoxDecoration(

                    color:
                        getStatusColor(
                          widget.pesanan.status,
                        ),

                    borderRadius:
                        BorderRadius.circular(
                      30,
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

            const SizedBox(height: 20),

            _infoTile(

              Icons.person,

              "Customer",

              widget.pesanan.customerNama,
            ),

            _infoTile(

              Icons.category,

              "Kategori",

              widget.pesanan.kategori,
            ),

                  _infoTile(

  Icons.flight,

  "Traveler",

  widget.pesanan.namaTraveler,
),

_infoTile(

  Icons.calendar_month,

  "Tanggal Kepulangan",

  widget.pesanan.tanggalKepulangan,
),
          ],
        ),
      ),

      const SizedBox(height: 20),

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

              "Alamat Pengiriman",

              style: TextStyle(

                fontSize: 18,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height:18),

            _infoTile(

              Icons.location_on,

              "Alamat",

              widget.pesanan.alamat,
            ),

            _infoTile(

              Icons.notes,

              "Catatan",

              widget.pesanan.notes,
            ),

          const SizedBox(height: 20),

const Text(
  "Update Status",
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 10),

DropdownButtonFormField<String>(
  value: selectedStatus,
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  items: statusList.map((status) {
    return DropdownMenuItem(
      value: status,
      child: Text(status),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      selectedStatus = value!;
    });
  },
),
          ],
        ),
      ),

      SizedBox(
  width: double.infinity,
  height: 54,
  child: ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xffB71C1C),
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    icon: const Icon(Icons.save),
    label: const Text(
      "Simpan Perubahan",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    onPressed: () async {
      await context.read<PesananViewModel>().updateStatus(
            widget.pesanan.id,
            selectedStatus,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Status berhasil diperbarui",
          ),
        ),
      );

      Navigator.pop(context);
    },
  ),
),

      const SizedBox(height:20),

          ],
        ),
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(
                0xffFDECEC,
              ),
              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(
                0xffB71C1C,
              ),
              size: 22,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  value.trim().isEmpty
                      ? "-"
                      : value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}