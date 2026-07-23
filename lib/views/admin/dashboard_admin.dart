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

    Future.microtask(() async {

  final vm =
      context.read<DashboardAdminViewModel>();

  await vm.getDashboard();

  if (!mounted) return;

  if ((vm.dashboardData?.reminderCount ?? 0) > 0) {

    _showReminderPopup();

  }
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

void _showReminderPopup() {

  showDialog(

    context: context,

    builder: (_) {

      return AlertDialog(

        shape: RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(20),

        ),

        title: const Row(

          children: [

            Icon(
              Icons.notifications_active,
              color: Colors.red,
            ),

            SizedBox(width: 10),

            Text("Pengingat"),

          ],

        ),

        content: const Text(

          "Ada customer yang mendekati deadline pelunasan.",

        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context);

            },

            child: const Text("Nanti"),

          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(context);

              _showReminderAdmin();

            },

            child: const Text("Lihat"),

          ),

        ],

      );

    },

  );

}

  void _showReminderAdmin() {
  final dashboardVM =
      context.read<DashboardAdminViewModel>();

  final reminder =
      dashboardVM.dashboardData?.reminder ?? [];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: reminder.isEmpty
            ? const SizedBox(
                height: 180,
                child: Center(
                  child: Text(
                    "Tidak ada pengingat pelunasan.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Center(
                    child: Text(
                      "Pengingat Pelunasan",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Ada ${reminder.length} customer mendekati deadline.",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ListView.separated(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: reminder.length,
                    separatorBuilder:
                        (_, __) =>
                            const Divider(),
                    itemBuilder: (_, index) {

                      final item =
                          reminder[index];

                      Color warna =
                          Colors.orange;

                      if (item.sisaHari <= 1) {
                        warna = Colors.red;
                      }

                      return ListTile(

                        leading: CircleAvatar(
                          backgroundColor:
                              warna.withOpacity(.15),
                          child: Icon(
                            Icons.notifications,
                            color: warna,
                          ),
                        ),

                        title: Text(
                          item.customer,
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        subtitle: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [

                            const SizedBox(
                                height: 4),

                            Text(
                              item.namaBarang,
                            ),

                            const SizedBox(
                                height: 4),

                            Text(
                              "Deadline : ${item.deadlinePelunasan}",
                            ),

                            Text(
                              "Sisa ${item.sisaHari} hari",
                              style: TextStyle(
                                color: warna,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
      );
    },
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

  title: const Text(
    "Dashboard",
  ),

  actions: [

    Stack(

      children: [

        IconButton(

  icon: const Icon(
    Icons.notifications_none,
  ),

  onPressed: () {
    debugPrint("NOTIF DIKLIK");
    _showReminderAdmin();
  },

),

        if ((data?.reminderCount ?? 0) > 0)

          Positioned(

            right: 10,

            top: 10,

            child: Container(

              width: 18,

              height: 18,

              decoration:
                  const BoxDecoration(

                color: Colors.red,

                shape: BoxShape.circle,

              ),

              child: Center(

                child: Text(

                  "${data?.reminderCount ?? 0}",

                  style: const TextStyle(

                    color: Colors.white,

                    fontSize: 10,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),

              ),

            ),

          ),

      ],

    ),

  ],

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

                                  "Halo Admin ",

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
                          ],
                        ),
                      ),
    );
  }
}