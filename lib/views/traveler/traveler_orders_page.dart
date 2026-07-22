import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../viewmodels/pesanan_viewmodel.dart';

import '../../viewmodels/auth_viewmodel.dart';

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
  @override
void initState() {
  super.initState();

  Future.microtask(() {
    final auth =
        context.read<AuthViewModel>();

    context
        .read<PesananViewModel>()
        .getPesananTraveler(
          auth.userId!,
        );
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
      
      case "On Hold":
        return Colors.deepOrange;

      case "Tidak Ditemukan":
        return Colors.red;

      case "Dibatalkan":
          return Colors.grey;

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

SizedBox(
  width: double.infinity,
  child: OutlinedButton.icon(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xffB71C1C),
      side: const BorderSide(
        color: Color(0xffB71C1C),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
    icon: const Icon(Icons.edit_note),
    label: const Text("Update"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailPesananPage(
            pesanan: pesanan,
          ),
        ),
      );
    },
  ),
),

const SizedBox(
  height: 6,
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