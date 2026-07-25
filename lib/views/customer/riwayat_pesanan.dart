import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/pesanan_viewmodel.dart';
import 'tracking_page.dart';
import '../../viewmodels/auth_viewmodel.dart';

class RiwayatPesananPage extends StatefulWidget {
  const RiwayatPesananPage({
    super.key,
  });

  @override
  State<RiwayatPesananPage> createState() =>
      _RiwayatPesananPageState();
}

class _RiwayatPesananPageState
    extends State<RiwayatPesananPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {

  final authVM = context.read<AuthViewModel>();
  final pesananVM = context.read<PesananViewModel>();

  pesananVM.currentUserId = authVM.userId;

  pesananVM.getPesanan();

});
  }

  Color getStatusColor(String status) {
    switch (status) {
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

        title: const Text(

          "Pesanan Saya",

          style: TextStyle(

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: pesananVM.isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : pesananVM
                  .pesananList
                  .isEmpty

              ? Center(

                  child: Column(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Icon(

                        Icons.shopping_bag_outlined,

                        size: 90,

                        color: Colors.grey.shade400,
                      ),

                      const SizedBox(
                          height: 16),

                      const Text(

                        "Belum Ada Pesanan",

                        style: TextStyle(

                          fontSize: 20,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height: 6),

                      const Text(

                        "Pesanan yang telah dibuat\nakan muncul di sini.",

                        textAlign:
                            TextAlign.center,

                        style: TextStyle(

                          color:
                              Colors.black54,
                        ),
                      ),
                    ],
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
                            .pesananList[index];
                            return Container(

  margin: const EdgeInsets.only(
    bottom: 18,
  ),

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

  child: Padding(

    padding:
        const EdgeInsets.all(18),

    child: Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Row(

          children: [

            const CircleAvatar(

              radius:24,

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

                  fontSize:18,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            Container(

              padding:
                  const EdgeInsets.symmetric(

                horizontal:12,

                vertical:6,
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

                  fontSize:12,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height:18),

        Row(

          children: [

            const Icon(

              Icons.category,

              size:18,

              color:
                  Colors.black54,
            ),

            const SizedBox(width:8),

            Expanded(

              child: Text(

                pesanan.kategori,
              ),
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

                style:
                    const TextStyle(

                  fontWeight:
                      FontWeight.w600,
                ),
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

            Expanded(

              child: Text(

                pesanan
                    .tanggalKepulangan,
              ),
            ),
          ],
        ),

        const SizedBox(height:22),

        SizedBox(

          width:
              double.infinity,

          height:48,

          child: ElevatedButton.icon(

            style:
                ElevatedButton.styleFrom(

              backgroundColor:
                  const Color(
                      0xffB71C1C),

              foregroundColor:
                  Colors.white,

              elevation:0,

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

              "Lacak Pesanan",
            ),

            onPressed: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) => TrackingPage(
  pesanan: pesanan,
),
                ),
              );
            },
          ),
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