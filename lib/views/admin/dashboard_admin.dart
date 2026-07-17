import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/dashboard_admin_viewmodel.dart';

class DashboardAdminPage extends StatefulWidget {
  const DashboardAdminPage({
    super.key,
  });

  @override
  State<DashboardAdminPage> createState() =>
      _DashboardAdminPageState();
}

class _DashboardAdminPageState
    extends State<DashboardAdminPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<DashboardAdminViewModel>()
          .getDashboard();
    });
  }

  Widget buildCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            radius: 22,
            backgroundColor:
                const Color(0xffFDECEC),
            child: Icon(
              icon,
              color:
                  const Color(0xffB71C1C),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              fontWeight:
                  FontWeight.bold,
              color:
                  Color(0xffB71C1C),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            "Data terbaru",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final dashboardVM =
        context.watch<
            DashboardAdminViewModel>();

    final data =
        dashboardVM.dashboardData;

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

          "Dashboard Admin",

          style: TextStyle(

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body:
          dashboardVM.isLoading

              ? const Center(

                  child:
                      CircularProgressIndicator(),
                )

              : data == null

                  ? const Center(

                      child: Text(
                        "Data tidak ditemukan",
                      ),
                    )

                  : SingleChildScrollView(

                      padding:
                          const EdgeInsets.all(
                        20,
                      ),

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Container(

                            width: double.infinity,

                            padding:
                                const EdgeInsets.all(
                              24,
                            ),

                            decoration:
                                BoxDecoration(

                              borderRadius:
                                  BorderRadius.circular(
                                24,
                              ),

                              gradient:
                                  const LinearGradient(

                                begin:
                                    Alignment.topLeft,

                                end:
                                    Alignment.bottomRight,

                                colors: [

                                  Color(0xffE53935),

                                  Color(0xff8E0000),
                                ],
                              ),
                            ),

                            child: Column(

                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                const Text(

                                  "Halo Admin 👋",

                                  style:
                                      TextStyle(

                                    color:
                                        Colors.white,

                                    fontSize: 28,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                const Text(

                                  "Selamat datang kembali.\nKelola seluruh aktivitas Jastip Korea dari dashboard ini.",

                                  style:
                                      TextStyle(

                                    color:
                                        Colors.white70,

                                    height: 1.4,
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                Container(

                                  padding:
                                      const EdgeInsets.all(
                                    18,
                                  ),

                                  decoration:
                                      BoxDecoration(

                                    color:
                                        Colors.white24,

                                    borderRadius:
                                        BorderRadius.circular(
                                      18,
                                    ),
                                  ),

                                                                  child: Row(

                                      children: [

                                        const CircleAvatar(

                                          radius: 28,

                                          backgroundColor:
                                              Colors.white,

                                          child: Icon(

                                            Icons.dashboard,

                                            color:
                                                Color(0xffB71C1C),

                                            size: 30,
                                          ),
                                        ),

                                        const SizedBox(
                                          width: 16,
                                        ),

                                        Expanded(

                                          child: Column(

                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,

                                            children: [

                                              const Text(

                                                "Total Pesanan",

                                                style: TextStyle(

                                                  color:
                                                      Colors.white70,
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 4,
                                              ),

                                              Text(

                                                data.totalOrders.toString(),

                                                style:
                                                    const TextStyle(

                                                  color:
                                                      Colors.white,

                                                  fontSize: 30,

                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 28),

                            const Text(

                              "Ringkasan",

                              style: TextStyle(

                                fontSize: 20,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            Row(

                              children: [

                                Expanded(

                                  child: buildCard(

                                    title: "Customer",

                                    value: data.totalCustomer.toString(),

                                    icon: Icons.people,
                                  ),
                                ),

                                const SizedBox(width: 14),

                                Expanded(

                                  child: buildCard(

                                    title: "Traveler",

                                    value: data.totalTraveler.toString(),

                                    icon: Icons.flight_takeoff,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            Row(

                              children: [

                                Expanded(

                                  child: buildCard(

                                    title: "Pesanan",

                                    value: data.totalOrders.toString(),

                                    icon: Icons.shopping_bag,
                                  ),
                                ),

                                const SizedBox(width: 14),

                                Expanded(

                                  child: buildCard(

                                    title: "Transaksi",

                                    value: data.totalTransaksi.toString(),

                                    icon: Icons.payments,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            const Text(

  "Status Pesanan",

  style: TextStyle(

    fontSize: 20,

    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 16),

Container(

  padding: const EdgeInsets.all(20),

  decoration: BoxDecoration(

    color: Colors.white,

    borderRadius: BorderRadius.circular(20),

    boxShadow: [

      BoxShadow(

        color: Colors.black.withOpacity(.05),

        blurRadius: 10,

        offset: const Offset(0,4),
      ),
    ],
  ),

  child: Column(

    children: [

      Row(

        children: [

          const CircleAvatar(

            radius: 8,

            backgroundColor: Colors.orange,
          ),

          const SizedBox(width: 12),

          const Expanded(

            child: Text(

              "Pending",

              style: TextStyle(

                fontWeight: FontWeight.w600,

                fontSize: 16,
              ),
            ),
          ),

          Container(

            padding: const EdgeInsets.symmetric(

              horizontal: 12,

              vertical: 6,
            ),

            decoration: BoxDecoration(

              color: Colors.orange,

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: const Text(

              "5",

              style: TextStyle(

                color: Colors.white,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      const Divider(height: 28),

      Row(

        children: [

          const CircleAvatar(

            radius: 8,

            backgroundColor: Colors.blue,
          ),

          const SizedBox(width: 12),

          const Expanded(

            child: Text(

              "Diproses",

              style: TextStyle(

                fontWeight: FontWeight.w600,

                fontSize: 16,
              ),
            ),
          ),

          Container(

            padding: const EdgeInsets.symmetric(

              horizontal: 12,

              vertical: 6,
            ),

            decoration: BoxDecoration(

              color: Colors.blue,

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: const Text(

              "8",

              style: TextStyle(

                color: Colors.white,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      const Divider(height: 28),

      Row(

        children: [

          const CircleAvatar(

            radius: 8,

            backgroundColor: Colors.purple,
          ),

          const SizedBox(width: 12),

          const Expanded(

            child: Text(

              "Dalam Pengiriman",

              style: TextStyle(

                fontWeight: FontWeight.w600,

                fontSize: 16,
              ),
            ),
          ),

          Container(

            padding: const EdgeInsets.symmetric(

              horizontal: 12,

              vertical: 6,
            ),

            decoration: BoxDecoration(

              color: Colors.purple,

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: const Text(

              "4",

              style: TextStyle(

                color: Colors.white,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      const Divider(height: 28),

      Row(

        children: [

          const CircleAvatar(

            radius: 8,

            backgroundColor: Colors.green,
          ),

          const SizedBox(width: 12),

          const Expanded(

            child: Text(

              "Selesai",

              style: TextStyle(

                fontWeight: FontWeight.w600,

                fontSize: 16,
              ),
            ),
          ),

          Container(

            padding: const EdgeInsets.symmetric(

              horizontal: 12,

              vertical: 6,
            ),

            decoration: BoxDecoration(

              color: Colors.green,

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: const Text(

              "15",

              style: TextStyle(

                color: Colors.white,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ],
  ),
),

const SizedBox(height: 20),
                          ],
                        ),
                      ),
    );
  }
}