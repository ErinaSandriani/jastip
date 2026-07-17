import 'package:provider/provider.dart';

import '../../viewmodels/traveler_viewmodel.dart';

import 'package:flutter/material.dart';

import '../../models/traveler_model.dart';

class DetailTravelerAdmin extends StatelessWidget {

  final TravelerModel traveler;

  const DetailTravelerAdmin({

    super.key,

    required this.traveler,
  });

  Color getStatusColor(String status){

    switch(status){

      case "pending":
        return Colors.orange;

      case "approved":
        return Colors.green;

      case "rejected":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status){

    switch(status){

      case "pending":
        return "Menunggu Verifikasi";

      case "approved":
        return "Traveler Aktif";

      case "rejected":
        return "Pendaftaran Ditolak";

      default:
        return status;
    }
  }

  Widget buildItem({

    required IconData icon,

    required String title,

    required String value,

  }){

    return Container(

      margin: const EdgeInsets.only(
        bottom: 18,
      ),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withOpacity(.05),

            blurRadius: 8,

            offset: const Offset(0,3),
          ),
        ],
      ),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          CircleAvatar(

            radius: 22,

            backgroundColor:
                const Color(0xffFDECEC),

            child: Icon(

              icon,

              color:
                  const Color(0xffB71C1C),
            ),
          ),

          const SizedBox(width:16),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: const TextStyle(

                    color: Colors.grey,

                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                const SizedBox(height:6),

                Text(

                  value,

                  style: const TextStyle(

                    fontSize:16,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
        return Scaffold(

      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(

        elevation: 0,

        backgroundColor: Colors.white,

        foregroundColor: Colors.black,

        centerTitle: true,

        title: const Text(

          "Detail Traveler",

          style: TextStyle(

            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(

              width: double.infinity,

              padding: const EdgeInsets.symmetric(

                vertical: 18,
              ),

              decoration: BoxDecoration(

                color: getStatusColor(
                  traveler.statusVerifikasi,
                ),

                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Column(

                children: [

                  Icon(

                    Icons.verified_user,

                    color: Colors.white,

                    size: 42,
                  ),

                  const SizedBox(height: 10),

                  Text(

                    getStatusText(
                      traveler.statusVerifikasi,
                    ),

                    style: const TextStyle(

                      color: Colors.white,

                      fontSize: 18,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            buildItem(

              icon: Icons.person,

              title: "Nama",

              value: traveler.nama,
            ),

            buildItem(

              icon: Icons.email,

              title: "Email",

              value: traveler.email,
            ),

            buildItem(

              icon: Icons.phone,

              title: "Nomor HP",

              value: traveler.noHp,
            ),

            buildItem(

              icon: Icons.location_on,

              title: "Alamat",

              value: traveler.alamat,
            ),

            buildItem(

              icon: Icons.calendar_month,

              title: "Tanggal Pulang",

              value: traveler.tanggalPulang.isEmpty

                  ? "Belum mengisi tanggal pulang"

                  : traveler.tanggalPulang,
            ),

            const SizedBox(height: 25),
                        if (traveler.statusVerifikasi == "pending") ...[

              Row(

                children: [

                  Expanded(

                    child: OutlinedButton.icon(

                      style: OutlinedButton.styleFrom(

                        foregroundColor: Colors.red,

                        side: const BorderSide(
                          color: Colors.red,
                        ),

                        minimumSize:
                            const Size.fromHeight(55),

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),

                      onPressed: () async {

  final confirm = await showDialog<bool>(

    context: context,

    builder: (_) {

      return AlertDialog(

        title: const Text("Tolak Traveler"),

        content: const Text(
          "Apakah Anda yakin ingin menolak traveler ini?",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context, false);

            },

            child: const Text("Batal"),
          ),

          ElevatedButton(

            style: ElevatedButton.styleFrom(

              backgroundColor: Colors.red,

              foregroundColor: Colors.white,
            ),

            onPressed: () {

              Navigator.pop(context, true);

            },

            child: const Text("Tolak"),
          ),
        ],
      );
    },
  );

  if (confirm != true) return;

  final success = await context
      .read<TravelerViewModel>()
      .rejectTraveler(traveler.id);

  if (!context.mounted) return;

  if (success) {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "Traveler berhasil ditolak.",
        ),
      ),
    );

    Navigator.pop(context);

  } else {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "Gagal menolak traveler.",
        ),
      ),
    );
  }
},
                      icon: const Icon(
                        Icons.close,
                      ),

                      label: const Text(
                        "Tolak",
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(

                    child: ElevatedButton.icon(

                      style: ElevatedButton.styleFrom(

                        backgroundColor:
                            const Color(
                          0xff2E7D32,
                        ),

                        foregroundColor:
                            Colors.white,

                        minimumSize:
                            const Size.fromHeight(55),

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),

                      onPressed: () async {

  final confirm = await showDialog<bool>(

    context: context,

    builder: (_) {

      return AlertDialog(

        title: const Text("Approve Traveler"),

        content: const Text(
          "Apakah Anda yakin ingin menyetujui traveler ini?",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context, false);

            },

            child: const Text("Batal"),
          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(context, true);

            },

            child: const Text("Approve"),
          ),
        ],
      );
    },
  );

  if (confirm != true) return;

  final success = await context
      .read<TravelerViewModel>()
      .approveTraveler(traveler.id);

  if (!context.mounted) return;

  if (success) {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "Traveler berhasil disetujui.",
        ),
      ),
    );

    Navigator.pop(context);

  } else {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "Gagal menyetujui traveler.",
        ),
      ),
    );
  }
},
                      icon: const Icon(
                        Icons.check,
                      ),

                      label: const Text(
                        "Approve",
                      ),
                    ),
                  ),
                ],
              ),

            ] else if (traveler.statusVerifikasi == "approved") ...[

              Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(16),

                decoration: BoxDecoration(

                  color: Colors.green.shade50,

                  borderRadius:
                      BorderRadius.circular(14),
                ),

                child: const Row(

                  children: [

                    Icon(

                      Icons.check_circle,

                      color: Colors.green,
                    ),

                    SizedBox(width: 10),

                    Expanded(

                      child: Text(

                        "Traveler sudah aktif.",

                        style: TextStyle(

                          color: Colors.green,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ] else ...[

              Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(16),

                decoration: BoxDecoration(

                  color: Colors.red.shade50,

                  borderRadius:
                      BorderRadius.circular(14),
                ),

                child: const Row(

                  children: [

                    Icon(

                      Icons.cancel,

                      color: Colors.red,
                    ),

                    SizedBox(width: 10),

                    Expanded(

                      child: Text(

                        "Pendaftaran traveler telah ditolak.",

                        style: TextStyle(

                          color: Colors.red,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}