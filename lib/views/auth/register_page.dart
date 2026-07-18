import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {

  final namaController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  Future<void> register() async {

    final authViewModel =
        Provider.of<AuthViewModel>(
      context,
      listen: false,
    );

    final success =
        await authViewModel.register(

      namaController.text,

      emailController.text,

      passwordController.text,
    );

    if (!mounted) return;

    if (success) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Register berhasil",
          ),
        ),
      );

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
              const LoginPage(),
        ),
      );

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(
            authViewModel.message,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF8F8F8),

          appBar: AppBar(
  backgroundColor: const Color(0xffF8F8F8),
  elevation: 0,
  scrolledUnderElevation: 0,
  foregroundColor: const Color(0xff212121),
),

      body: SafeArea(
  child: SingleChildScrollView(
    child: Padding(

    padding: const EdgeInsets.symmetric(
  horizontal: 24,
  vertical: 24,
),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 20),

Center(
  child: Container(
    width: 90,
    height: 90,
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
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: const Color(0xffB71C1C).withOpacity(.25),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: const Icon(
      Icons.shopping_bag_rounded,
      color: Colors.white,
      size: 45,
    ),
  ),
),

const SizedBox(height: 24),

const Center(
  child: Text(
    "Join Us",
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  ),
),
        
            const SizedBox(height: 8),

            const Center(
  child: Text(
    "Create an account to start\nshopping from Korea.",
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.black54,
      height: 1.5,
    ),
  ),
),

            const SizedBox(height: 30),

            TextField(

              controller:
                  namaController,

              decoration:
                  InputDecoration(

                labelText: "Username",
                contentPadding:

    const EdgeInsets.symmetric(
      vertical: 18,
    ),

                prefixIcon:
                    const Icon(Icons.person),

                filled: true,

                fillColor: Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          16),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(

              controller:
                  emailController,

              decoration:
                  InputDecoration(

                labelText: "Email",
                contentPadding:

    const EdgeInsets.symmetric(
      vertical: 18,
    ),

                prefixIcon:
                    const Icon(Icons.email),

                filled: true,

                fillColor: Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          16),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(

              controller:
                  passwordController,

              obscureText: true,

              decoration:
                  InputDecoration(

                labelText: "Password",
                contentPadding:

    const EdgeInsets.symmetric(
      vertical: 18,
    ),

                prefixIcon:
                    const Icon(Icons.lock),

                filled: true,

                fillColor: Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          16),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

                         SizedBox(

              width: double.infinity,

              height: 58,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(0xffB71C1C),

                  foregroundColor:
                      Colors.white,

                  elevation: 3,

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),
                ),

                onPressed: register,

                child: const Text(

                  "Create Account",

                  style: TextStyle(

                    fontSize: 16,

                    fontWeight:
                        FontWeight.bold,

                    letterSpacing: .5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                const Text(

                  "Already have an account?",

                  style: TextStyle(

                    color: Colors.black54,
                  ),
                ),

                TextButton(

                  onPressed: () {

                    Navigator.pushReplacement(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            const LoginPage(),
                      ),
                    );
                  },

                  child: const Text(

                    "Sign In",

                    style: TextStyle(

                      color:
                          Color(0xffB71C1C),

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
                ),
      ),
    ),
  ),
);
  }
}