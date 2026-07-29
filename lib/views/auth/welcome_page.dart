import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../customer/customer_main_page.dart';
import '../traveler/traveler_home.dart';
import '../admin/admin_page.dart';

import 'register_traveler_page.dart';
import 'login_page.dart';
import 'register_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSession();
    });
  }

  Future<void> _checkSession() async {

    final auth = context.read<AuthViewModel>();

    final loggedIn =
        await auth.loadSession();

    if (!mounted || !loggedIn) return;

    Widget page;

    if (auth.userRole == "customer") {

      page = const CustomerMainPage();

    } else if (auth.userRole == "traveler") {

      page = const TravelerHomePage();

    } else {

      page = const AdminPage();

    }

    Navigator.pushReplacement(

      context,

      MaterialPageRoute(
        builder: (_) => page,
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 24,
          ),

          child: Column(
            children: [

              const Spacer(),

              // Logo
              Container(
                width: 110,
                height: 110,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff8B0000),
                      Color(0xffB71C1C),
                      Color(0xffD32F2F),
                    ],
                  ),

                  borderRadius: BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffB71C1C)
                          .withOpacity(.25),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.shopping_bag_rounded,
                  color: Colors.white,
                  size: 55,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "JASTIP KOREA",
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  color: Color(0xff212121),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Belanja Korea lebih mudah,\ncepat, dan terpercaya.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.7,
                ),
              ),

              const SizedBox(height: 45),

              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [

                  _featureChip(
                    Icons.checkroom,
                    "Fashion",
                  ),

                  _featureChip(
                    Icons.album,
                    "Merchandise",
                  ),

                  _featureChip(
                    Icons.spa,
                    "Skincare",
                  ),

                  _featureChip(
                    Icons.face_retouching_natural,
                    "Make Up",
                  ),
                ],
              ),

              const Spacer(),

                             SizedBox(
                width: double.infinity,
                height: 56,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffB71C1C),
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shadowColor: const Color(0xffD32F2F),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    );
                  },

                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
  width: double.infinity,
  height: 56,

  child: OutlinedButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xffB71C1C),

      side: const BorderSide(
        color: Color(0xffB71C1C),
        width: 1.5,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    onPressed: () {

      Navigator.push(

        context,

        MaterialPageRoute(
          builder: (_) =>
              const RegisterPage(),
        ),
      );
    },

    child: const Text(
      "Create Account",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: .5,
      ),
    ),
  ),
),

const SizedBox(height: 18),

Row(

  mainAxisAlignment: MainAxisAlignment.center,

  children: [

    const Text(

      "Ingin menjadi Traveler?",

      style: TextStyle(

        color: Colors.black54,

        fontSize: 14,
      ),
    ),

    TextButton(

  onPressed: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const RegisterTravelerPage(),

      ),

    );

  },

      child: const Text(

        "Daftar di sini",

        style: TextStyle(

          color: Color(0xffB71C1C),

          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),

const SizedBox(height: 28),

              Container(
                width: 70,
                height: 4,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff8B0000),
                      Color(0xffD32F2F),
                    ],
                  ),

                  borderRadius: BorderRadius.circular(30),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Trusted Korean Shopping Service",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                  letterSpacing: .8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _featureChip(
    IconData icon,
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(30),

        border: Border.all(
          color: Colors.grey.shade300,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            color: const Color(0xffB71C1C),
            size: 18,
          ),

          const SizedBox(width: 8),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}