import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/traveler_viewmodel.dart';

class ReturnDatePage extends StatefulWidget {
  const ReturnDatePage({
    super.key,
  });

  @override
  State<ReturnDatePage> createState() =>
      _ReturnDatePageState();
}

class _ReturnDatePageState
    extends State<ReturnDatePage> {

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickDate() async {

    final picked = await showDatePicker(

      context: context,

      initialDate:
          selectedDate ??
              DateTime.now(),

      firstDate:
          DateTime.now(),

      lastDate:
          DateTime(2035),
    );

    if (picked != null) {

      setState(() {

        selectedDate = picked;

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final travelerVM =
        context.watch<TravelerViewModel>();

    final auth =
        context.watch<AuthViewModel>();

    final int travelerId =
        auth.userId ?? 0;

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

          "Jadwal Kepulangan",

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

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(

              width: double.infinity,

              padding:
                  const EdgeInsets.all(22),

              decoration: BoxDecoration(

                borderRadius:
                    BorderRadius.circular(22),

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

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Traveler",

                    style: TextStyle(

                      color:
                          Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(

                    auth.namaUser,

                    style:
                        const TextStyle(

                      color:
                          Colors.white,

                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(

                    "Atur tanggal kepulangan agar Customer dapat memilih jadwal jastip Anda.",

                    style: TextStyle(

                      color:
                          Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Container(

              width: double.infinity,

              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black.withOpacity(.05),

                    blurRadius: 8,

                    offset:
                        const Offset(0,3),
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Tanggal Kepulangan",

                    style: TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(

                    width: double.infinity,

                    padding:
                        const EdgeInsets.all(16),

                    decoration:
                        BoxDecoration(

                      color:
                          const Color(0xffF8F8F8),

                      borderRadius:
                          BorderRadius.circular(14),
                    ),

                    child: Row(

                      children: [

                        const Icon(

                          Icons.calendar_month,

                          color:
                              Color(0xffB71C1C),
                        ),

                        const SizedBox(width: 12),

                        Expanded(

                          child: Text(

                            selectedDate == null

                                ? "Belum memilih tanggal"

                                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",

                            style:
                                const TextStyle(

                              fontSize: 16,
                            ),
                          ),
                        ),

                        IconButton(

                          onPressed: pickDate,

                          icon: const Icon(

                            Icons.edit_calendar,

                            color:
                                Color(0xffB71C1C),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),
                  SizedBox(

  width: double.infinity,

  height: 50,

  child: ElevatedButton.icon(

    style:
        ElevatedButton.styleFrom(

      backgroundColor:
          const Color(0xffB71C1C),

      foregroundColor:
          Colors.white,

      shape:
          RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(
          14,
        ),
      ),
    ),

    onPressed: () async {

      if (selectedDate == null) {

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(

          const SnackBar(

            content: Text(

              "Silakan pilih tanggal terlebih dahulu",
            ),
          ),
        );

        return;
      }

      final success =
          await travelerVM
              .updateReturnDate(

        travelerId: travelerId,

        date: selectedDate!,
      );

      if (!mounted) return;

      if (success) {

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(

          const SnackBar(

            content: Text(

              "Tanggal kepulangan berhasil diperbarui",
            ),
          ),
        );

      } else {

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(

          const SnackBar(

            content: Text(

              "Gagal memperbarui tanggal kepulangan",
            ),
          ),
        );
      }
    },

    icon: const Icon(
      Icons.save,
    ),

    label: const Text(
      "Simpan Tanggal",
    ),
  ),
),

const SizedBox(height: 12),

SizedBox(

  width: double.infinity,

  height: 50,

  child: OutlinedButton.icon(

    style:
        OutlinedButton.styleFrom(

      foregroundColor:
          Colors.red,

      side:
          const BorderSide(

        color: Colors.red,
      ),

      shape:
          RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(
          14,
        ),
      ),
    ),

    onPressed: () async {

      final success =
          await travelerVM
              .deleteReturnDate(

        travelerId,
      );

      if (!mounted) return;

      if (success) {

        setState(() {

          selectedDate = null;

        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(

          const SnackBar(

            content: Text(

              "Tanggal kepulangan berhasil dihapus",
            ),
          ),
        );

      } else {

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(

          const SnackBar(

            content: Text(

              "Gagal menghapus tanggal kepulangan",
            ),
          ),
        );
      }
    },

    icon: const Icon(
      Icons.delete,
    ),

    label: const Text(
      "Hapus Tanggal",
    ),
  ),
),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}