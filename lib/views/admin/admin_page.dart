import 'package:flutter/material.dart';

import 'dashboard_admin.dart';

import 'pesanan_admin.dart';

import 'traveler_admin.dart';

import 'profile_admin.dart';

class AdminPage
    extends StatefulWidget {

  const AdminPage({
    super.key,
  });

  @override
  State<AdminPage>
      createState() =>
          _AdminPageState();
}

class _AdminPageState
    extends State<AdminPage> {

  int currentIndex = 0;

  final List<Widget> pages = [

    const DashboardAdminPage(),

    const PesananAdminPage(),

    const TravelerAdminPage(),

    const ProfileAdminPage(),
  ];

  @override
Widget build(BuildContext context) {

  return Scaffold(

    body: SafeArea(

      child: pages[currentIndex],
    ),

    bottomNavigationBar: Container(

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: const BorderRadius.only(

          topLeft: Radius.circular(24),

          topRight: Radius.circular(24),
        ),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withOpacity(.08),

            blurRadius: 15,

            offset: const Offset(0, -3),
          ),
        ],
      ),

      child: ClipRRect(

        borderRadius: const BorderRadius.only(

          topLeft: Radius.circular(24),

          topRight: Radius.circular(24),
        ),

        child: BottomNavigationBar(

          currentIndex: currentIndex,

          type: BottomNavigationBarType.fixed,

          backgroundColor: Colors.white,

          elevation: 0,

          selectedItemColor: const Color(0xffB71C1C),

          unselectedItemColor: Colors.grey,

          selectedFontSize: 13,

          unselectedFontSize: 12,

          selectedLabelStyle: const TextStyle(

            fontWeight: FontWeight.bold,
          ),

          onTap: (index) {

            setState(() {

              currentIndex = index;

            });
          },

          items: const [

            BottomNavigationBarItem(

              icon: Icon(

                Icons.dashboard_rounded,
              ),

              label: "Dashboard",
            ),

            BottomNavigationBarItem(

              icon: Icon(

                Icons.shopping_bag_rounded,
              ),

              label: "Pesanan",
            ),

            BottomNavigationBarItem(

              icon: Icon(

                Icons.flight_takeoff_rounded,
              ),

              label: "Traveler",
            ),

            BottomNavigationBarItem(

              icon: Icon(

                Icons.person_rounded,
              ),

              label: "Profile",
            ),
          ],
        ),
      ),
    ),
  );
}
    }