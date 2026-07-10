import 'package:flutter/material.dart';

import '../../models/pesanan_model.dart';

import 'assign_traveler.dart';

class DetailPesananAdmin
    extends StatelessWidget {

  final Pesanan pesanan;

  const DetailPesananAdmin({

    super.key,

    required this.pesanan,
  });

  Widget buildItem({

    required String title,

    required String value,
  }) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 16,
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(

            title,

            style: const TextStyle(

              fontWeight:
                  FontWeight.bold,

              color: Colors.grey,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(
            value,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Detail Pesanan",
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(
          16,
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            buildItem(

              title:
                  "Kategori Barang",

              value:
                  pesanan.namaBarang,
            ),

            buildItem(

              title:
                  "Detail Barang",

              value:
                  pesanan.notes,
            ),

            buildItem(

              title:
                  "Status",

              value:
                  pesanan.status,
            ),

            buildItem(

              title:
                  "Traveler",

              value: pesanan
                      .namaTraveler
                      .isEmpty

                  ? "Belum dipilih"

                  : pesanan
                      .namaTraveler,
            ),

            buildItem(

              title:
                  "Estimasi Kepulangan",

              value: pesanan
                  .tanggalKepulangan,
            ),

            const SizedBox(
              height: 20,
            ),

            const Text(

              "Bukti DP",

              style: TextStyle(

                fontSize: 18,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Container(

              height: 200,

              width: double.infinity,

              decoration: BoxDecoration(

                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                color:
                    Colors.grey.shade300,
              ),

              child: const Center(

                child: Text(
                  "Preview Bukti DP",
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(

              width:
                  double.infinity,

              height: 50,

              child:
                  ElevatedButton.icon(

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder:
                          (_) =>
                              AssignTravelerPage(

                        pesanan:
                            pesanan,
                      ),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.flight,
                ),

                label: const Text(
                  "Assign Traveler",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}