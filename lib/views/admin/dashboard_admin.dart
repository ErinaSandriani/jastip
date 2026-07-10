import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../viewmodels/dashboard_admin_viewmodel.dart';

class DashboardAdminPage
    extends StatefulWidget {

  const DashboardAdminPage({
    super.key,
  });

  @override
  State<DashboardAdminPage>
      createState() =>
          _DashboardAdminPageState();
}

class _DashboardAdminPageState
    extends State<DashboardAdminPage> {

  @override
  void initState() {

    super.initState();

    Future.microtask(() {

      context

          .read<
              DashboardAdminViewModel>()

          .getDashboard();
    });
  }

  Widget buildCard({

    required String title,

    required String value,

    required IconData icon,
  }) {

    return Container(

      padding:
          const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        boxShadow: [

          BoxShadow(

            color: Colors.grey
                .withOpacity(0.2),

            blurRadius: 8,
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(

            icon,

            size: 32,

            color: Colors.pink,
          ),

          const SizedBox(
            height: 12,
          ),

          Text(

            value,

            style: const TextStyle(

              fontSize: 24,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final dashboardViewModel =
        context.watch<
            DashboardAdminViewModel>();

    final data =
        dashboardViewModel
            .dashboardData;

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Dashboard Admin",
        ),
      ),

      body:
          dashboardViewModel
                  .isLoading

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

                  : Padding(

                      padding:
                          const EdgeInsets.all(
                        16,
                      ),

                      child: GridView.count(

                        crossAxisCount: 2,

                        crossAxisSpacing:
                            16,

                        mainAxisSpacing:
                            16,

                        children: [

                          buildCard(

                            title:
                                "Total Pesanan",

                            value: data
                                .totalOrders
                                .toString(),

                            icon: Icons
                                .shopping_bag,
                          ),

                          buildCard(

                            title:
                                "Customer",

                            value: data
                                .totalCustomer
                                .toString(),

                            icon:
                                Icons.people,
                          ),

                          buildCard(

                            title:
                                "Traveler",

                            value: data
                                .totalTraveler
                                .toString(),

                            icon:
                                Icons.flight,
                          ),

                          buildCard(

                            title:
                                "Transaksi",

                            value: data
                                .totalTransaksi
                                .toString(),

                            icon:
                                Icons.payments,
                          ),
                        ],
                      ),
                    ),
    );
  }
}