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

        backgroundColor: Colors.white,

        elevation: 0,

        centerTitle: true,

        foregroundColor:
            const Color(0xff212121),

        title: const Text(

          "Create Account",

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.symmetric(

          horizontal: 24,

          vertical: 10,
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 10),

            const Text(

              "Join Us",

              style: TextStyle(

                fontSize: 28,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(

              "Create an account to start\nshopping from Korea.",

              style: TextStyle(

                color: Colors.black54,

                height: 1.5,
              ),
            ),

            const SizedBox(height: 35),

            TextField(

              controller:
                  namaController,

              decoration:
                  InputDecoration(

                labelText: "Username",

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

              height: 55,

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

            const SizedBox(height: 22),

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
    );
  }
}