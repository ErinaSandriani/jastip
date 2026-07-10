import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/pesanan_viewmodel.dart';

import 'profile_traveler.dart';
import 'return_date_page.dart';
import 'traveler_orders_page.dart';

class TravelerHomePage extends StatefulWidget {

  const TravelerHomePage({
    super.key,
  });

  @override
  State<TravelerHomePage> createState() =>
      _TravelerHomePageState();
}

class _TravelerHomePageState
    extends State<TravelerHomePage> {

  @override
  void initState() {

    super.initState();

    Future.microtask(() {

      context
          .read<PesananViewModel>()
          .getPesanan();

    });
  }

  @override
  Widget build(BuildContext context) {

    final auth =
        context.watch<AuthViewModel>();

    final pesananVM =
        context.watch<PesananViewModel>();

    final pesananList =
        pesananVM.pesananList;

    final pending =
        pesananList
            .where(
              (e) =>
                  e.status ==
                  "Pending",
            )
            .length;

    final diproses =
        pesananList
            .where(
              (e) =>
                  e.status ==
                  "Diproses",
            )
            .length;

    final dikirim =
        pesananList
            .where(
              (e) =>
                  e.status ==
                  "Dalam Pengiriman",
            )
            .length;

    final selesai =
        pesananList
            .where(
              (e) =>
                  e.status ==
                  "Selesai",
            )
            .length;

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

          "Traveler Dashboard",

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

          : SingleChildScrollView(

              padding:
                  const EdgeInsets.all(
                20,
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Container(

                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets.all(
                      22,
                    ),

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                        22,
                      ),

                      gradient:
                          const LinearGradient(

                        begin:
                            Alignment.topLeft,

                        end:
                            Alignment.bottomRight,

                        colors: [

                          Color(0xffE53935),

                          Color(0xffB71C1C),

                        ],
                      ),
                    ),

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Text(

                          "Selamat Datang 👋",

                          style: TextStyle(

                            color:
                                Colors.white70,

                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(

                          auth.namaUser,

                          style:
                              const TextStyle(

                            color:
                                Colors.white,

                            fontSize: 26,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Text(

                          "Kelola seluruh titipan customer dengan mudah.",

                          style: TextStyle(

                            color:
                                Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 28,
                  ),
                  // 🔥 STATISTIK
const Text(

  "Statistik",

  style: TextStyle(

    fontSize: 20,

    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 16),

Row(

  children: [

    Expanded(

      child: _buildStatCard(

        icon: Icons.pending_actions,

        title: "Pending",

        value: pending.toString(),

        color: Colors.orange,
      ),
    ),

    const SizedBox(width: 12),

    Expanded(

      child: _buildStatCard(

        icon: Icons.sync,

        title: "Diproses",

        value: diproses.toString(),

        color: Colors.blue,
      ),
    ),
  ],
),

const SizedBox(height: 12),

Row(

  children: [

    Expanded(

      child: _buildStatCard(

        icon: Icons.local_shipping,

        title: "Dikirim",

        value: dikirim.toString(),

        color: Colors.purple,
      ),
    ),

    const SizedBox(width: 12),

    Expanded(

      child: _buildStatCard(

        icon: Icons.check_circle,

        title: "Selesai",

        value: selesai.toString(),

        color: Colors.green,
      ),
    ),
  ],
),

const SizedBox(height: 28),

const Text(

  "Quick Menu",

  style: TextStyle(

    fontSize: 20,

    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 16),

Row(

  children: [

    Expanded(

      child: _buildMenuCard(

        context: context,

        icon: Icons.inventory_2_outlined,

        title: "Pesanan",

        page: const TravelerOrdersPage(),
      ),
    ),

    const SizedBox(width: 10),

    Expanded(

      child: _buildMenuCard(

        context: context,

        icon: Icons.calendar_month,

        title: "Jadwal",

        page: const ReturnDatePage(),
      ),
    ),

    const SizedBox(width: 10),

    Expanded(

      child: _buildMenuCard(

        context: context,

        icon: Icons.person_outline,

        title: "Profile",

        page: const ProfileTravelerPage(),
      ),
    ),
  ],
),

const SizedBox(height: 28),

const Text(

  "Aktivitas Terbaru",

  style: TextStyle(

    fontSize: 20,

    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 16),

if (pesananList.isEmpty)

Container(

  width: double.infinity,

  padding: const EdgeInsets.all(22),

  decoration: BoxDecoration(

    color: Colors.white,

    borderRadius:
        BorderRadius.circular(18),

    boxShadow: [

      BoxShadow(

        color: Colors.black.withOpacity(.05),

        blurRadius: 8,

        offset: const Offset(0,3),
      ),
    ],
  ),

  child: const Column(

    children: [

      Icon(

        Icons.inventory_2_outlined,

        size: 60,

        color: Colors.grey,
      ),

      SizedBox(height: 12),

      Text(

        "Belum ada aktivitas",

        style: TextStyle(

          fontWeight: FontWeight.bold,

          fontSize: 16,
        ),
      ),

      SizedBox(height: 6),

      Text(

        "Pesanan customer akan muncul di sini.",

        textAlign: TextAlign.center,

        style: TextStyle(

          color: Colors.black54,
        ),
      ),
    ],
  ),
)

else

...pesananList.take(3).map(

  (pesanan) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withOpacity(.05),

            blurRadius: 8,

            offset: const Offset(0,3),
          ),
        ],
      ),

      child: ListTile(

        contentPadding:
            const EdgeInsets.symmetric(

          horizontal: 16,

          vertical: 8,
        ),

        leading: CircleAvatar(

          backgroundColor:
              _getStatusColor(
            pesanan.status,
          ),

          child: const Icon(

            Icons.shopping_bag,

            color: Colors.white,
          ),
        ),

        title: Text(

          pesanan.namaBarang,

          style: const TextStyle(

            fontWeight:
                FontWeight.bold,
          ),
        ),

        subtitle: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 4),

            Text(
              pesanan.namaTraveler,
            ),

            Text(

              pesanan.tanggalKepulangan,

              style: const TextStyle(

                color: Colors.black54,

                fontSize: 12,
              ),
            ),
          ],
        ),

        trailing: Container(

          padding:
              const EdgeInsets.symmetric(

            horizontal: 10,

            vertical: 5,
          ),

          decoration: BoxDecoration(

            color:
                _getStatusColor(
                  pesanan.status,
                ).withOpacity(.15),

            borderRadius:
                BorderRadius.circular(20),
          ),

          child: Text(

            pesanan.status,

            style: TextStyle(

              color:
                  _getStatusColor(
                    pesanan.status,
                  ),

              fontWeight:
                  FontWeight.bold,

              fontSize: 12,
            ),
          ),
        ),
      ),
    );

  },

).toList(),

                ],
              ),
            ),
    );
  }
  Widget _buildStatCard({

  required IconData icon,

  required String title,

  required String value,

  required Color color,

}) {

  return Container(

    padding: const EdgeInsets.symmetric(

      vertical: 18,

      horizontal: 12,
    ),

    decoration: BoxDecoration(

      color: Colors.white,

      borderRadius:
          BorderRadius.circular(18),

      boxShadow: [

        BoxShadow(

          color:
              Colors.black.withOpacity(.05),

          blurRadius: 8,

          offset:
              const Offset(0,3),
        ),
      ],
    ),

    child: Column(

      mainAxisAlignment:
          MainAxisAlignment.center,

      children: [

        CircleAvatar(

          radius: 22,

          backgroundColor:
              color.withOpacity(.15),

          child: Icon(

            icon,

            color: color,

            size: 24,
          ),
        ),

        const SizedBox(height: 12),

        Text(

          value,

          style: const TextStyle(

            fontSize: 22,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(

          title,

          style: const TextStyle(

            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

Widget _buildMenuCard({

  required BuildContext context,

  required IconData icon,

  required String title,

  required Widget page,

}) {

  return InkWell(

    borderRadius:
        BorderRadius.circular(18),

    onTap: () {

      Navigator.push(

        context,

        MaterialPageRoute(

          builder: (_) => page,
        ),
      );
    },

    child: Container(

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(.05),

            blurRadius: 8,

            offset:
                const Offset(0,3),
          ),
        ],
      ),

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          CircleAvatar(

            radius: 26,

            backgroundColor:
                const Color(
                    0xffFDECEC),

            child: Icon(

              icon,

              size: 28,

              color:
                  const Color(
                      0xffB71C1C),
            ),
          ),

          const SizedBox(height: 12),

          Text(

            title,

            style: const TextStyle(

              fontWeight:
                  FontWeight.bold,

              fontSize: 15,
            ),
          ),
        ],
      ),
    ),
  );
}

Color _getStatusColor(
  String status,
) {

  switch (status) {

    case "Pending":
      return Colors.orange;

    case "Diproses":
      return Colors.blue;

    case "Dikirim":
    case "Dalam Pengiriman":
      return Colors.purple;

    case "Selesai":
      return Colors.green;

    default:
      return Colors.grey;
  }
}
}