import 'package:flutter/material.dart';

import 'kategori_page.dart';
import 'profile_customer.dart';
import 'riwayat_pesanan.dart';

class CustomerMainPage extends StatefulWidget {
  const CustomerMainPage({
    super.key,
  });

  @override
  State<CustomerMainPage> createState() =>
      _CustomerMainPageState();
}

class _CustomerMainPageState
    extends State<CustomerMainPage> {

  int currentIndex = 0;

  final List<Widget> pages = [

    const KategoriPage(),

    const RiwayatPesananPage(),

    const ProfileCustomerPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF8F8F8),

      body: pages[currentIndex],

      bottomNavigationBar: Container(

        decoration: const BoxDecoration(

          color: Colors.white,

          boxShadow: [

            BoxShadow(

              color: Colors.black12,

              blurRadius: 12,

              offset: Offset(0, -2),
            ),
          ],
        ),

        child: BottomNavigationBar(

          currentIndex: currentIndex,

          onTap: (index) {

            setState(() {

              currentIndex = index;
            });
          },

          backgroundColor: Colors.white,

          elevation: 0,

          selectedItemColor:
              const Color(0xffB71C1C),

          unselectedItemColor:
              Colors.grey,

          selectedLabelStyle:
              const TextStyle(

            fontWeight: FontWeight.bold,

            fontSize: 12,
          ),

          unselectedLabelStyle:
              const TextStyle(

            fontSize: 12,
          ),

          type:
              BottomNavigationBarType.fixed,

          items: const [

            BottomNavigationBarItem(

              icon: Icon(Icons.home_rounded),

              label: "Home",
            ),

            BottomNavigationBarItem(

              icon: Icon(
                Icons.shopping_bag_rounded,
              ),

              label: "Pesanan",
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
    );
  }
}