import 'package:flutter/material.dart';

import '../../models/pesanan_model.dart';

class DetailPesananAdmin extends StatelessWidget {

  final Pesanan pesanan;

  const DetailPesananAdmin({

    super.key,

    required this.pesanan,
  });

  Color getStatusColor(String status){

    switch(status){

      case "Pending":
        return Colors.orange;

      case "Dibeli":
        return Colors.blue;

      case "Dalam Perjalanan":
        return Colors.purple;

      case "Dikirim":
        return Colors.indigo;

      case "Selesai":
        return Colors.green;

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

                          pesanan.namaBarang,

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
                            pesanan.status,
                          ),

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: Text(

                      pesanan.status,

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

                    value: pesanan.namaBarang,
                  ),

                  infoTile(

                    icon: Icons.notes,

                    title: "Detail Barang",

                    value: pesanan.notes,
                  ),

                  infoTile(

                    icon: Icons.person,

                    title: "Customer",

                    value: pesanan.customerNama,
                  ),

                  infoTile(

                    icon: Icons.flight_takeoff,

                    title: "Traveler",

                    value: pesanan.namaTraveler.isEmpty

                        ? "Belum dipilih"

                        : pesanan.namaTraveler,
                  ),

                  infoTile(

                    icon: Icons.calendar_month,

                    title: "Estimasi Kepulangan",

                    value: pesanan.tanggalKepulangan,
                  ),

                  infoTile(

                    icon: Icons.location_on,

                    title: "Alamat Pengiriman",

                    value: pesanan.alamat,
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

                  ClipRRect(

                    borderRadius:
                        BorderRadius.circular(16),

                    child: Container(

                      width: double.infinity,

                      height:220,

                      color:
                          Colors.grey.shade200,

                      child: const Column(

                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Icon(

                            Icons.image,

                            size:60,

                            color: Colors.grey,
                          ),

                          SizedBox(height:12),

                          Text(

                            "Preview Bukti Transfer",

                            style: TextStyle(

                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height:30),

SizedBox(

  width: double.infinity,

  height: 54,

  child: ElevatedButton.icon(

    style: ElevatedButton.styleFrom(

      backgroundColor:
          const Color(0xffB71C1C),

      foregroundColor:
          Colors.white,

      shape:
          RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(16),
      ),
    ),

    onPressed: () {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(

            "Pesanan berhasil dikonfirmasi",
          ),
        ),
      );
    },

    icon: const Icon(

      Icons.verified,
    ),

    label: const Text(

      "Konfirmasi Pesanan",

      style: TextStyle(

        fontSize:16,

        fontWeight:
            FontWeight.bold,
      ),
    ),
  ),
),
            const SizedBox(height:20),
          ],
        ),
      ),
    );
  }
}