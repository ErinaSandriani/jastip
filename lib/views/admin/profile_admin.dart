import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../auth/welcome_page.dart';

class ProfileAdminPage extends StatelessWidget {
  const ProfileAdminPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

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

      "Profile Admin",

      style: TextStyle(

        fontWeight:
            FontWeight.bold,
      ),
    ),
  ),

  body: SingleChildScrollView(

    padding:
        const EdgeInsets.all(20),

    child: Column(

      children: [

        Container(

          width: double.infinity,

          padding:
              const EdgeInsets.all(24),

          decoration: BoxDecoration(

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

            children: [

              const CircleAvatar(

                radius: 42,

                backgroundColor:
                    Colors.white,

                child: Icon(

                  Icons.admin_panel_settings,

                  size: 42,

                  color:
                      Color(0xff8E0000),
                ),
              ),

              const SizedBox(height:18),

              Text(

                auth.namaUser,

                style:
                    const TextStyle(

                  color:
                      Colors.white,

                  fontSize:24,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height:6),

              Text(

                auth.emailUser,

                style:
                    const TextStyle(

                  color:
                      Colors.white70,
                ),
              ),

              const SizedBox(height:16),

              Container(

                padding:
                    const EdgeInsets.symmetric(

                  horizontal:18,

                  vertical:8,
                ),

                decoration: BoxDecoration(

                  color:
                      Colors.white24,

                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                ),

                child: const Text(

                  "Administrator",

                  style: TextStyle(

                    color:
                        Colors.white,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height:24),

        Container(

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(
              20,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withOpacity(.05),

                blurRadius:10,

                offset:
                    const Offset(0,4),
              ),
            ],
          ),

          child: Column(

            children: [

              ListTile(

                leading: const CircleAvatar(

                  backgroundColor:
                      Color(0xffFDECEC),

                  child: Icon(

                    Icons.person,

                    color:
                        Color(0xffB71C1C),
                  ),
                ),

                title:
                    const Text("Nama"),

                subtitle:
                    Text(auth.namaUser),
              ),

              const Divider(height:0),

              ListTile(

                leading: const CircleAvatar(

                  backgroundColor:
                      Color(0xffFDECEC),

                  child: Icon(

                    Icons.email,

                    color:
                        Color(0xffB71C1C),
                  ),
                ),

                title:
                    const Text("Email"),

                subtitle:
                    Text(auth.emailUser),
              ),

              const Divider(height:0),

              ListTile(

                leading: const CircleAvatar(

                  backgroundColor:
                      Color(0xffFDECEC),

                  child: Icon(

                    Icons.badge,

                    color:
                        Color(0xffB71C1C),
                  ),
                ),

                title:
                    const Text("Role"),

                subtitle:
                    Text(auth.userRole),
              ),
            ],
          ),
        ),

        const SizedBox(height:30),

            SizedBox(

  width: double.infinity,

  height: 54,

  child: ElevatedButton.icon(

    style:
        ElevatedButton.styleFrom(

      backgroundColor:
          const Color(
              0xffB71C1C),

      foregroundColor:
          Colors.white,

      elevation: 0,

      shape:
          RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),
    ),

    icon: const Icon(
      Icons.logout_rounded,
    ),

    label: const Text(

      "Logout",

      style: TextStyle(

        fontSize: 16,

        fontWeight:
            FontWeight.bold,
      ),
    ),

    onPressed: () async {

      final logout =
          await showDialog<bool>(

        context: context,

        builder: (_) {

          return AlertDialog(

            shape:
                RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            title:
                const Text("Logout"),

            content:
                const Text(

              "Apakah Anda yakin ingin keluar dari akun admin?",
            ),

            actions: [

              TextButton(

                onPressed: () {

                  Navigator.pop(
                    context,
                    false,
                  );
                },

                child: const Text(
                  "Batal",
                ),
              ),

              ElevatedButton(

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(
                          0xffB71C1C),

                  foregroundColor:
                      Colors.white,
                ),

                onPressed: () {

                  Navigator.pop(
                    context,
                    true,
                  );
                },

                child: const Text(
                  "Logout",
                ),
              ),
            ],
          );
        },
      );

      if (logout == true) {

        context
            .read<AuthViewModel>()
            .logout();

        Navigator.pushAndRemoveUntil(

          context,

          MaterialPageRoute(

            builder: (_) =>
                const WelcomePage(),
          ),

          (route) => false,
        );
      }
    },
  ),
),

const SizedBox(height:20),

],
),
),
);
}
}