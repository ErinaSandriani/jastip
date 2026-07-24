import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../auth/welcome_page.dart';

class ProfileTravelerPage extends StatelessWidget {

  const ProfileTravelerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final auth =
        context.watch<AuthViewModel>();

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

          "Profile Traveler",

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

              width:
                  double.infinity,

              padding:
                  const EdgeInsets.all(24),

              decoration: BoxDecoration(

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

  children: [

    Align(

      alignment: Alignment.topRight,

      child: CircleAvatar(

        radius: 18,

        backgroundColor: Colors.white24,

        child: IconButton(

          padding: EdgeInsets.zero,

          icon: const Icon(

            Icons.edit_outlined,

            color: Colors.white,

            size: 18,

          ),

          tooltip: "Edit Profil",

          onPressed: () {

            _showEditProfileDialog(context);

          },
        ),
      ),
    ),

    const CircleAvatar(

      radius: 42,

      backgroundColor: Colors.white,

      child: Icon(

        Icons.flight_takeoff,

        color: Color(0xffB71C1C),

        size: 42,
      ),
    ),

                  const SizedBox(height: 18),

                  Text(

                    auth.namaUser,

                    style:
                        const TextStyle(

                      color:
                          Colors.white,

                      fontSize: 22,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(

                    auth.emailUser,

                    style:
                        const TextStyle(

                      color:
                          Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black.withOpacity(
                            .05),

                    blurRadius: 8,

                    offset:
                        const Offset(
                            0, 3),
                  ),
                ],
              ),

              

              child: Column(

                children: [

                  ListTile(

                    leading: CircleAvatar(

                      backgroundColor:
                          const Color(
                              0xffFDECEC),

                      child: const Icon(

                        Icons.person,

                        color:
                            Color(
                                0xffB71C1C),
                      ),
                    ),

                    title:
                        const Text("Nama"),

                    subtitle: Text(
                      auth.namaUser,
                    ),
                  ),

                  const Divider(height: 0),

                  ListTile(

                    leading: CircleAvatar(

                      backgroundColor:
                          const Color(
                              0xffFDECEC),

                      child: const Icon(

                        Icons.email,

                        color:
                            Color(
                                0xffB71C1C),
                      ),
                    ),

                    title:
                        const Text("Email"),

                    subtitle: Text(
                      auth.emailUser,
                    ),
                  ),

                  const Divider(height: 0),

ListTile(

  leading: CircleAvatar(

    backgroundColor: const Color(0xffFDECEC),

    child: const Icon(

      Icons.phone,

      color: Color(0xffB71C1C),

    ),
  ),

  title: const Text("Nomor HP"),

  subtitle: Text(

    auth.noHpUser.isEmpty
        ? "-"
        : auth.noHpUser,

  ),
),

                  const Divider(height: 0),

                  ListTile(

                    leading: CircleAvatar(

                      backgroundColor:
                          const Color(
                              0xffFDECEC),

                      child: const Icon(

                        Icons.badge,

                        color:
                            Color(
                                0xffB71C1C),
                      ),
                    ),

                    title:
                        const Text("Role"),

                    subtitle: Text(
                      auth.userRole,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            SizedBox( 

  height: 52,

  child: ElevatedButton.icon(

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

    style:
        ElevatedButton.styleFrom(

      backgroundColor:
          const Color(0xffB71C1C),

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

    onPressed: () async {

      final result =
          await showDialog<bool>(

        context: context,

        builder: (_) => AlertDialog(

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
              18,
            ),
          ),

          title: const Text(
            "Logout",
          ),

          content: const Text(

            "Apakah Anda yakin ingin keluar dari akun traveler?",
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
        ),
      );

      if (result == true) {

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
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(
  BuildContext context,
) {

  final auth =
      context.read<AuthViewModel>();

  final namaController =
      TextEditingController(
    text: auth.namaUser,
  );

  final hpController =
      TextEditingController(
    text: auth.noHpUser,
  );

  showDialog(

    context: context,

    builder: (_) {

      return AlertDialog(

        shape: RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(20),
        ),

        title: const Text(
          "Edit Profil",
        ),

        content: Column(

          mainAxisSize:
              MainAxisSize.min,

          children: [

            TextField(

              controller:
                  namaController,

              decoration:
                  const InputDecoration(

                labelText: "Nama",
              ),
            ),

            const SizedBox(height: 15),

            TextField(

              controller:
                  hpController,

              keyboardType:
                  TextInputType.phone,

              decoration:
                  const InputDecoration(

                labelText: "Nomor HP",
              ),
            ),
          ],
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context);

            },

            child:
                const Text("Batal"),
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

            onPressed: () async {

              final navigator =
                  Navigator.of(context);

              final messenger =
                  ScaffoldMessenger.of(
                      context);

              final success =
                  await auth.updateProfile(

                nama:
                    namaController.text,

                noHp:
                    hpController.text,

              );

              navigator.pop();

              messenger.showSnackBar(

                SnackBar(

                  content: Text(

                    success

                        ? "Profil berhasil diperbarui"

                        : "Gagal memperbarui profil",

                  ),
                ),
              );
            },

            child:
                const Text("Simpan"),
          ),
        ],
      );
    },
  );
}
}