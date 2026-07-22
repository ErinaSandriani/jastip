import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';

import '../customer/customer_main_page.dart';
import '../traveler/traveler_home.dart';
import '../admin/admin_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authViewModel =
        context.watch<AuthViewModel>();

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

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

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

            const SizedBox(height: 30),

            const Center(
  child: Text(
    "Welcome Back",
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  ),
),

            const SizedBox(height: 8),

            const Center(
  child: Text(
    "Sign in to continue your\nKorean shopping journey.",
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.black54,
      height: 1.5,
    ),
  ),
),

            const SizedBox(height: 35),

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

                        authViewModel.isLoading

                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffB71C1C),
                    ),
                  )

                : SizedBox(

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

                      onPressed: () async {

                        final success =
                            await authViewModel
                                .login(

                          emailController.text,

                          passwordController
                              .text,
                        );

                        if (!mounted) return;

                        if (success) {

                          final role =
                              authViewModel
                                  .userRole;

                          // CUSTOMER
                          if (role ==
                              "customer") {

                            Navigator.pushAndRemoveUntil(
                             context,
                             MaterialPageRoute(
                                  builder: (_) => const CustomerMainPage(),
                                   ),
                                  (route) => false,
                                    );

                          // TRAVELER
                          } else if (
                              role ==
                              "traveler") {

                            Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (_) => const TravelerHomePage(),
  ),
  (route) => false,
);

                          // ADMIN
                          } else if (
                              role ==
                              "admin") {

                            Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (_) => const AdminPage(),
  ),
  (route) => false,
);

                          } else {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(

                              const SnackBar(

                                content: Text(
                                  "Role tidak dikenali",
                                ),
                              ),
                            );
                          }

                        } else {

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(

                            SnackBar(

                              content: Text(

                                authViewModel
                                    .message,
                              ),
                            ),
                          );
                        }
                      },

                      child: const Text(

                        "Sign In",

                        style: TextStyle(

                          fontSize: 16,

                          fontWeight:
                              FontWeight.bold,

                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ),

            const SizedBox(height: 20),

            Row(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                const Text(

                  "Don't have an account?",

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
                            const RegisterPage(),
                      ),
                    );
                  },

                  child: const Text(

                    "Register",

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