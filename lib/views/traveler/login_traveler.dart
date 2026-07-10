import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';

import '../customer/customer_main_page.dart';
import '../traveler/traveler_home.dart';
import '../admin/admin_page.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

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

  Future<void> login() async {

    final authViewModel =
        Provider.of<AuthViewModel>(
      context,
      listen: false,
    );

    final success =
        await authViewModel.login(

      emailController.text,

      passwordController.text,
    );

    if (!mounted) return;

    if (success) {

      final role =
          authViewModel.userRole;

      if (role == "admin") {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
                const AdminPage(),
          ),
        );

      } else if (role == "traveler") {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
                const TravelerHomePage(),
          ),
        );

      } else {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
                const CustomerMainPage(),
          ),
        );
      }

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

    final authViewModel =
        Provider.of<AuthViewModel>(
      context,
    );

    return Scaffold(

      appBar: AppBar(

        title: const Text("Login"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller:
                  emailController,

              decoration:
                  const InputDecoration(

                labelText: "Email",

                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(

              controller:
                  passwordController,

              obscureText: true,

              decoration:
                  const InputDecoration(

                labelText:
                    "Password",

                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(

              width: double.infinity,

              height: 50,

              child: ElevatedButton(

                onPressed:
                    authViewModel.isLoading

                        ? null
                        : login,

                child:
                    authViewModel.isLoading

                        ? const CircularProgressIndicator(
                            color:
                                Colors.white,
                          )

                        : const Text(
                            "Login",
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}