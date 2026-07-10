import 'package:flutter/material.dart';

import '../../models/pesanan_model.dart';

class TrackingPage extends StatelessWidget {

  final Pesanan pesanan;

  const TrackingPage({

    super.key,

    required this.pesanan,
  });

  Color getStatusColor(String status){

    switch(status){

      case "Pending":
        return Colors.orange;

      case "Diproses":
        return Colors.blue;

      case "Dikirim":
        return Colors.purple;

      case "Selesai":
        return Colors.green;

      default:
        return Colors.grey;
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

        title: const Text(

          "Tracking Pesanan",

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
                    BorderRadius.circular(
                  20,
                ),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black
                        .withOpacity(.05),

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

                      const SizedBox(width:12),

                      Expanded(

                        child: Text(

                          pesanan.namaBarang,

                          style:
                              const TextStyle(

                            fontSize:20,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height:20),

                  Row(

                    children: [

                      const Icon(

                        Icons.category,

                        size:18,

                        color:
                            Colors.black54,
                      ),

                      const SizedBox(width:8),

                      Text(
                        pesanan.kategori,
                      ),
                    ],
                  ),

                  const SizedBox(height:10),

                  Row(

                    children: [

                      const Icon(

                        Icons.flight,

                        size:18,

                        color:
                            Colors.black54,
                      ),

                      const SizedBox(width:8),

                      Expanded(

                        child: Text(
                          pesanan.namaTraveler,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height:10),

                  Row(

                    children: [

                      const Icon(

                        Icons.calendar_month,

                        size:18,

                        color:
                            Colors.black54,
                      ),

                      const SizedBox(width:8),

                      Text(
                        pesanan.tanggalKepulangan,
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

            const SizedBox(height:24),

            const Text(

              "Tracking Pesanan",

              style: TextStyle(

                fontSize:20,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height:18),

            _trackingItem(

              "Pesanan Dibuat",

              true,
            ),

            _trackingItem(

              "Traveler Berbelanja",

              pesanan.status !=
                  "Pending",
            ),

            _trackingItem(

              "Barang Dikirim",

              pesanan.status ==
                      "Dikirim" ||

                  pesanan.status ==
                      "Selesai",
            ),

            _trackingItem(

              "Pesanan Selesai",

              pesanan.status ==
                  "Selesai",
            ),

            const SizedBox(height:30),

            Container(

              width:
                  double.infinity,

              padding:
                  const EdgeInsets.all(
                18,
              ),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black
                        .withOpacity(.05),

                    blurRadius:8,

                    offset:
                        const Offset(0,3),
                  ),
                ],
              ),

              child: Row(

                children: [

                  const Icon(

                    Icons.location_on,

                    color:
                        Color(0xffB71C1C),
                  ),

                  const SizedBox(width:12),

                  Expanded(

                    child: Text(

                      pesanan.alamat,
                    ),
                  ),
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

      padding:
          const EdgeInsets.only(
        bottom:18,
      ),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          CircleAvatar(

            radius:14,

            backgroundColor:

                active

                    ? const Color(
                        0xffB71C1C)

                    : Colors.grey
                        .shade300,

            child: Icon(

              active

                  ? Icons.check

                  : Icons.circle,

              size:14,

              color:
                  Colors.white,
            ),
          ),

          Container(

            width:2,

            height:40,

            margin:
                const EdgeInsets.symmetric(
              horizontal:13,
            ),

            color:
                active

                    ? const Color(
                        0xffB71C1C)

                    : Colors.grey
                        .shade300,
          ),

          Expanded(

            child: Padding(

              padding:
                  const EdgeInsets.only(
                top:4,
              ),

              child: Text(

                title,

                style: TextStyle(

                  fontSize:16,

                  fontWeight:

                      active

                          ? FontWeight.bold

                          : FontWeight.normal,

                  color:

                      active

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
}