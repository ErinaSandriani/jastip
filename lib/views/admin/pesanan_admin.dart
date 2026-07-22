import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pesanan_model.dart';
import '../../viewmodels/pesanan_viewmodel.dart';
import 'detail_pesanan_admin.dart';

class PesananAdminPage extends StatefulWidget {
  const PesananAdminPage({
    super.key,
  });

  @override
  State<PesananAdminPage> createState() =>
      _PesananAdminPageState();
}

class _PesananAdminPageState
    extends State<PesananAdminPage> {

  final TextEditingController
      searchController =
      TextEditingController();

  String keyword = "";

  final List<String> statusList = [
  "Semua",
  "Menunggu Konfirmasi",
  "Diproses",
  "Dalam Pengiriman",
  "Menunggu Pelunasan",
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

IconData getStatusIcon(String status) {
  switch (status) {
    case "Menunggu Konfirmasi Admin":
      return Icons.hourglass_top;

    case "Diproses":
      return Icons.settings;

    case "On Hold":
      return Icons.pause_circle;

    case "Tidak Ditemukan":
      return Icons.search_off;

    case "Dalam Pengiriman":
      return Icons.flight_takeoff;

    case "Menunggu Pelunasan":
      return Icons.payments;

    case "Dikirim ke Rumah Customer":
      return Icons.local_shipping;

    case "Selesai":
      return Icons.check_circle;

    case "Dibatalkan":
      return Icons.cancel;

    default:
      return Icons.info;
  }
}

  List<Pesanan> filterData(

  List<Pesanan> data,

  String status,

){

  return data.where((item){

    final key = keyword.toLowerCase();

    final cocokSearch =

        item.customerNama
            .toLowerCase()
            .contains(key) ||

        item.namaBarang
            .toLowerCase()
            .contains(key) ||

        item.namaTraveler
            .toLowerCase()
            .contains(key);

    if(status=="Semua"){

      return cocokSearch;
    }

    if (status == "Menunggu Konfirmasi") {
  return item.status == "Menunggu Konfirmasi Admin" &&
      cocokSearch;
}

if (status == "Diproses") {
  return [
    "Diproses",
    "On Hold",
    "Tidak Ditemukan",
  ].contains(item.status) &&
      cocokSearch;
}

if (status == "Dalam Pengiriman") {
  return item.status == "Dalam Pengiriman" &&
      cocokSearch;
}

if (status == "Menunggu Pelunasan") {
  return [
    "Menunggu Pelunasan",
    "Menunggu Verifikasi Pelunasan",
  ].contains(item.status) &&
      cocokSearch;
}

return item.status == status &&
    cocokSearch;

  }).toList();
}

  @override
  Widget build(BuildContext context) {

    final vm =
        context.watch<
            PesananViewModel>();

    return DefaultTabController(

      length: statusList.length,

      child: Scaffold(

        backgroundColor:
            const Color(
                0xffF5F5F5),

        appBar: AppBar(

          elevation: 0,

          backgroundColor:
              Colors.white,

          foregroundColor:
              Colors.black,

          centerTitle: true,

          title: const Text(

            "Kelola Pesanan",

            style: TextStyle(

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),

        body: vm.isLoading

            ? const Center(

                child:
                    CircularProgressIndicator(),
              )

            : Column(

                children: [

                  Padding(

                    padding:
                        const EdgeInsets.all(
                      16,
                    ),

                    child: TextField(

                      controller:
                          searchController,

                      onChanged: (v) {

                        setState(() {

                          keyword = v;

                        });
                      },

                      decoration:
                          InputDecoration(

                        hintText:
                            "Cari customer, barang, atau traveler...",

                        prefixIcon:
                            const Icon(
                          Icons.search,
                        ),

                        filled: true,

                        fillColor:
                            Colors.white,

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),

                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  TabBar(

                    isScrollable: true,

                    labelColor:
                        const Color(
                            0xffB71C1C),

                    unselectedLabelColor:
                        Colors.grey,

                    indicatorColor:
                        const Color(
                            0xffB71C1C),

                    tabs: statusList

                        .map(

                          (e) => Tab(

                            text: e,
                          ),
                        )

                        .toList(),
                  ),

                  Expanded(

                    child: TabBarView(

                      children:
                          statusList.map((status) {

                        final list =
                            filterData(

                          vm.pesananList,

                          status,
                        );

                        if (list.isEmpty) {

                          return const Center(

                            child: Text(

                              "Tidak ada pesanan",

                              style: TextStyle(

                                fontSize: 16,

                                color: Colors.grey,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(

                          padding:
                              const EdgeInsets.all(
                            16,
                          ),

                          itemCount:
                              list.length,

                          itemBuilder:
                              (context, index) {

                            final pesanan =
                                list[index];

                            return Container(

                              margin:
                                  const EdgeInsets.only(
                                bottom: 18,
                              ),

                              padding:
                                  const EdgeInsets.all(
                                18,
                              ),

                              decoration:
                                  BoxDecoration(

                                color: Colors.white,

                                borderRadius:
                                    BorderRadius.circular(
                                  22,
                                ),

                                boxShadow: [

                                  BoxShadow(

                                    color:
                                        Colors.black.withOpacity(
                                      .05,
                                    ),

                                    blurRadius: 10,

                                    offset:
                                        const Offset(
                                      0,
                                      4,
                                    ),
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

                                        radius: 24,

                                        backgroundColor:
                                            Color(
                                          0xffFDECEC,
                                        ),

                                        child: Icon(

                                          Icons.shopping_bag,

                                          color:
                                              Color(
                                            0xffB71C1C,
                                          ),
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
  pesanan.namaBarang.isNotEmpty
      ? pesanan.namaBarang
      : pesanan.kategori,
  style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
),

                                            const SizedBox(
                                              height: 4,
                                            ),

                                            Text(

                                              pesanan.customerNama,

                                              style:
                                                  const TextStyle(

                                                color:
                                                    Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(

                                        padding:
                                            const EdgeInsets.symmetric(

                                          horizontal: 12,

                                          vertical: 6,
                                        ),

                                        decoration:
                                            BoxDecoration(

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

                                            color:
                                                Colors.white,

                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),

                                  Row(

                                    children: [

                                      const Icon(

                                        Icons.flight_takeoff,

                                        size: 18,

                                        color:
                                            Colors.grey,
                                      ),

                                      const SizedBox(
                                        width: 8,
                                      ),

                                      Expanded(

                                        child: Text(

                                          pesanan.namaTraveler,

                                          style:
                                              const TextStyle(

                                            fontWeight:
                                                FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Row(

                                    children: [

                                      const Icon(

                                        Icons.location_on,

                                        size: 18,

                                        color:
                                            Colors.grey,
                                      ),

                                      const SizedBox(
                                        width: 8,
                                      ),

                                      Expanded(

                                        child: Text(

                                          pesanan.alamat,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  SizedBox(

                                    width:
                                        double.infinity,

                                    height: 48,

                                    child:
                                        ElevatedButton.icon(

                                      style:
                                          ElevatedButton.styleFrom(

                                        backgroundColor:
                                            const Color(
                                          0xffB71C1C,
                                        ),

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

                                      icon:
                                          const Icon(
                                        Icons.visibility,
                                      ),

                                      label:
                                          const Text(

                                        "Lihat Detail",
                                      ),

                                      onPressed: () {

                                        Navigator.push(

                                          context,

                                          MaterialPageRoute(

                                            builder: (_) =>
                                                DetailPesananAdmin(

                                              pesanan:
                                                  pesanan,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}