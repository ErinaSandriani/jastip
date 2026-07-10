import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../viewmodels/pesanan_viewmodel.dart';

import 'detail_pesanan.dart';

class TravelerOrdersPage
    extends StatefulWidget {

  const TravelerOrdersPage({
    super.key,
  });

  @override
  State<TravelerOrdersPage>
      createState() =>
          _TravelerOrdersPageState();
}

class _TravelerOrdersPageState
    extends State<TravelerOrdersPage> {

  final List<String> statusList = [

    "Pending",

    "Diproses",

    "Dalam Pengiriman",

    "Selesai",
  ];

  @override
  void initState() {

    super.initState();

    Future.microtask(() {

      context
          .read<PesananViewModel>()
          .getPesanan();
    });
  }

  Color getStatusColor(
    String status,
  ) {

    switch(status){

      case "Pending":
        return Colors.orange;

      case "Diproses":
        return Colors.blue;

      case "Dalam Pengiriman":
        return Colors.purple;

      case "Selesai":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    final pesananVM =
        context.watch<PesananViewModel>();

    return Scaffold(

  backgroundColor:
      const Color(0xffF5F5F5),

  appBar: AppBar(

    elevation: 0,

    backgroundColor:
        Colors.white,

    foregroundColor:
        Colors.black,

    centerTitle: true,

    title: const Text(

      "Pesanan Traveler",

      style: TextStyle(

        fontWeight:
            FontWeight.bold,
      ),
    ),
  ),

  body:
      pesananVM.isLoading

          ? const Center(

              child:
                  CircularProgressIndicator(),
            )

          : pesananVM
                  .pesananList
                  .isEmpty

              ? const Center(

                  child: Text(
                    "Belum ada pesanan",
                  ),
                )

              : ListView.builder(

                  padding:
                      const EdgeInsets.all(
                    18,
                  ),

                  itemCount:
                      pesananVM
                          .pesananList
                          .length,

                  itemBuilder:
                      (context, index) {

                    final pesanan =
                        pesananVM
                                .pesananList[
                            index];

                    String selectedStatus =
                        statusList.contains(
                                pesanan.status)

                            ? pesanan.status

                            : statusList.first;

                    return Container(

                      margin:
                          const EdgeInsets.only(
                        bottom: 20,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          22,
                        ),

                        boxShadow: [

                          BoxShadow(

                            color: Colors.black
                                .withOpacity(
                                    .05),

                            blurRadius: 10,

                            offset:
                                const Offset(
                                    0,
                                    4),
                          ),
                        ],
                      ),

                      child: Padding(

                        padding:
                            const EdgeInsets.all(
                          18,
                        ),

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Row(

                              children: [

                                const CircleAvatar(

                                  radius: 24,

                                  backgroundColor:
                                      Color(
                                          0xffFDECEC),

                                  child: Icon(

                                    Icons
                                        .shopping_bag,

                                    color:
                                        Color(
                                            0xffB71C1C),
                                  ),
                                ),

                                const SizedBox(
                                  width: 14,
                                ),

                                Expanded(

                                  child: Column(

                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,

                                    children: [

                                      Text(

                                        pesanan
                                            .namaBarang,

                                        style:
                                            const TextStyle(

                                          fontSize:
                                              18,

                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),
                                      ),

                                      const SizedBox(
                                          height:
                                              4),

                                      Text(

                                        pesanan
                                            .kategori,

                                        style:
                                            const TextStyle(

                                          color:
                                              Colors
                                                  .grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(

                                  padding:
                                      const EdgeInsets.symmetric(

                                    horizontal:
                                        12,

                                    vertical: 6,
                                  ),

                                  decoration:
                                      BoxDecoration(

                                    color:
                                        getStatusColor(

                                      pesanan
                                          .status,
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(
                                      30,
                                    ),
                                  ),

                                  child: Text(

                                    pesanan
                                        .status,

                                    style:
                                        const TextStyle(

                                      color:
                                          Colors
                                              .white,

                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 22,
                            ),

                            Row(

                              children: [

                                const Icon(

                                  Icons.person,

                                  size: 20,

                                  color:
                                      Color(
                                          0xffB71C1C),
                                ),

                                const SizedBox(
                                  width: 8,
                                ),

                                Expanded(

                                  child: Text(

                                    pesanan
                                        .customerNama,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Row(

                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                const Icon(

                                  Icons.location_on,

                                  size: 20,

                                  color:
                                      Color(
                                          0xffB71C1C),
                                ),

                                const SizedBox(
                                  width: 8,
                                ),

                                Expanded(

                                  child: Text(

                                    pesanan
                                        .alamat,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 22,
                            ),

                                DropdownButtonFormField<String>(

  value: selectedStatus,

  decoration: InputDecoration(

    labelText: "Update Status",

    filled: true,

    fillColor:
        const Color(0xffF8F8F8),

    border:
        OutlineInputBorder(

      borderRadius:
          BorderRadius.circular(
        14,
      ),

      borderSide:
          BorderSide.none,
    ),
  ),

  items:
      statusList.map(

    (status) {

      return DropdownMenuItem(

        value: status,

        child: Text(
          status,
        ),
      );
    },
  ).toList(),

  onChanged: (value) {

    setState(() {

      selectedStatus =
          value!;
    });
  },
),

const SizedBox(
  height: 22,
),

Row(

  children: [

    Expanded(

      child: OutlinedButton.icon(

        style:
            OutlinedButton.styleFrom(

          foregroundColor:
              const Color(
                  0xffB71C1C),

          side:
              const BorderSide(

            color:
                Color(
                    0xffB71C1C),
          ),

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),
        ),

        icon: const Icon(

          Icons.visibility,
        ),

        label: const Text(
          "Detail",
        ),

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  DetailPesananPage(

                pesanan: pesanan,
              ),
            ),
          );
        },
      ),
    ),

    const SizedBox(
      width: 12,
    ),

    Expanded(

      child: ElevatedButton.icon(

        style:
            ElevatedButton.styleFrom(

          backgroundColor:
              const Color(
                  0xffB71C1C),

          foregroundColor:
              Colors.white,

          elevation: 0,

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),
        ),

        icon: const Icon(
          Icons.save,
        ),

        label: const Text(
          "Simpan",
        ),

        onPressed: () async {

          await pesananVM
              .updateStatus(

            pesanan.id,

            selectedStatus,
          );

          if (!context.mounted) {
            return;
          }

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(

            const SnackBar(

              content: Text(

                "Status berhasil diperbarui",
              ),
            ),
          );
        },
      ),
    ),
  ],
),

const SizedBox(
  height: 6,
),
                                                           ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}