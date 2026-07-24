import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../auth/welcome_page.dart';

class ProfileCustomerPage extends StatelessWidget {

  const ProfileCustomerPage({
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

        elevation:0,

        backgroundColor:
            Colors.white,

        foregroundColor:
            Colors.black,

        title: const Text(

          "Profile",

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

            Stack(

  alignment: Alignment.topCenter,

  children: [

    Column(

      children: [

        const CircleAvatar(

          radius:55,

          backgroundColor:
              Color(0xffB71C1C),

          child: Icon(

            Icons.person,

            size:58,

            color: Colors.white,
          ),
        ),

        const SizedBox(height:18),

        Text(

          auth.namaUser,

          style: const TextStyle(

            fontSize:24,

            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height:6),

        Container(

          padding:
              const EdgeInsets.symmetric(

            horizontal:18,

            vertical:8,
          ),

          decoration: BoxDecoration(

            color:
                const Color(0xffFDECEC),

            borderRadius:
                BorderRadius.circular(30),
          ),

          child: Text(

            auth.userRole.toUpperCase(),

            style: const TextStyle(

              color:
                  Color(0xffB71C1C),

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ],
    ),

    Positioned(

      right: 0,

      child: CircleAvatar(

        radius:18,

        backgroundColor:
            const Color(0xffB71C1C),

        child: IconButton(

          padding: EdgeInsets.zero,

          icon: const Icon(

            Icons.edit_outlined,

            color: Colors.white,

            size:18,
          ),

          onPressed: () {

            _showEditCustomerDialog(context);

          },
        ),
      ),
    ),
  ],
),

            const SizedBox(height:18),

            Text(

              auth.namaUser,

              style: const TextStyle(

                fontSize:24,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height:6),

            Container(

              padding:
                  const EdgeInsets.symmetric(

                horizontal:18,

                vertical:8,
              ),

              decoration: BoxDecoration(

                color:
                    const Color(0xffFDECEC),

                borderRadius:
                    BorderRadius.circular(
                  30,
                ),
              ),

              child: Text(

                auth.userRole.toUpperCase(),

                style: const TextStyle(

                  color:
                      Color(0xffB71C1C),

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height:28),

            Card(

              elevation:0,

              shape:
                  RoundedRectangleBorder(

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),

              child: Padding(

                padding:
                    const EdgeInsets.all(
                  18,
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

                      title: const Text("Nama"),

                      subtitle:
                          Text(auth.namaUser),
                    ),

                    const Divider(),

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

                    const Divider(),

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
            ),

            const SizedBox(height:32),

            SizedBox(

  width: double.infinity,

  height: 55,

  child: ElevatedButton.icon(

    style:
        ElevatedButton.styleFrom(

      backgroundColor:
          const Color(0xffB71C1C),

      foregroundColor:
          Colors.white,

      elevation:0,

      shape:
          RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),
    ),

    icon: const Icon(
      Icons.logout,
    ),

    label: const Text(

      "Logout",

      style: TextStyle(

        fontSize:16,

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
                20,
              ),
            ),

            title: const Row(

              children: [

                Icon(

                  Icons.logout,

                  color:
                      Color(0xffB71C1C),
                ),

                SizedBox(width:10),

                Text("Logout"),
              ],
            ),

            content: const Text(

              "Apakah Anda yakin ingin keluar dari akun ini?",
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

const Text(

  "Jastip Korea v1.0",

  style: TextStyle(

    color: Colors.black45,

    fontSize:12,
  ),
),

],
),
),
);
}

void _showEditCustomerDialog(
    BuildContext context) {

  final auth =
      context.read<AuthViewModel>();

  final namaController =
      TextEditingController(

    text: auth.namaUser,

  );

  showDialog(

    context: context,

    builder: (_) {

      return AlertDialog(

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(20),
        ),

        title: const Text(
          "Edit Nama",
        ),

        content: TextField(

          controller:
              namaController,

          decoration:
              const InputDecoration(

            labelText: "Nama",

          ),
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context);

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
                    auth.noHpUser,

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