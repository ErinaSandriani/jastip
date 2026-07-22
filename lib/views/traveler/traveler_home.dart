import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/pesanan_viewmodel.dart';

import 'profile_traveler.dart';
import 'return_date_page.dart';
import 'traveler_orders_page.dart';

class TravelerHomePage extends StatefulWidget {
  const TravelerHomePage({super.key});

  @override
  State<TravelerHomePage> createState() => _TravelerHomePageState();
}

class _TravelerHomePageState extends State<TravelerHomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PesananViewModel>().getPesanan();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildDashboard(),
      const TravelerOrdersPage(),
      const ReturnDatePage(),
      const ProfileTravelerPage(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xffB71C1C),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: "Pesanan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Jadwal",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    final auth = context.watch<AuthViewModel>();
    final pesananVM = context.watch<PesananViewModel>();

    final pesananList = pesananVM.pesananList;

    final pending = pesananList
        .where((e) => e.status == "Pending")
        .length;

    final diproses = pesananList
        .where((e) => e.status == "Diproses")
        .length;

    final dikirim = pesananList
        .where((e) => e.status == "Dalam Pengiriman")
        .length;

    final selesai = pesananList
        .where((e) => e.status == "Selesai")
        .length;

    if (pesananVM.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,

        title: const Text(
          "Traveler Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),

                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    Color(0xffE53935),
                    Color(0xffB71C1C),
                  ],
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Selamat Datang 👋",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    auth.namaUser,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Kelola seluruh titipan customer dengan mudah.",

                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

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
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(.15),

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
              fontWeight: FontWeight.bold,
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
}